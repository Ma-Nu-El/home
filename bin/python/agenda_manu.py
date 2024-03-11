#!/usr/bin/env python3

import sys               # to read input
import holidays
import calendar
import datetime
import orgparse

class PersonalHolidays(holidays.Chile):
     def _populate(self, year):
         holidays.Chile._populate(self, year)
         # self[datetime.date(2023, 5, 22)] = "RTT"
         # self[datetime.date(2023, 7, 13)] = "RTT"

personal_holidays = PersonalHolidays()

current_year = datetime.datetime.now().year
today = datetime.date.today()

color = { "month"    : "\033[1;37;40m"  , # Bright white text, black background
          "week"     : "\033[30m"       , # Gray text (text color set to black, but no background color specified)
          "weekend"  : "\033[0;2m"      , # Dim text
          "vacant"   : "\033[0;2m"      , # Dim text
          "busy-0"   : "\033[0m"        , # Reset/default text
          "busy-1"   : "\033[48;5;223m" , # Light Orange background
          "busy-2"   : "\033[48;5;216m" , # Vibrant orange background
          "busy-3"   : "\033[48;5;209m" , # Even more intense orange background
          "busy-4"   : "\033[48;5;202m" , # Deep orange/red background
          "deadline" : "\033[1;31m"     , # Bright red text
          "today"    : "\033[1;30;42m"  , # Text: black, bold; background: green
          "reset"    : "\033[0m"          # Resets the color to the terminal's default
         }

markers = {
    "busy-0" : " ",
    "busy-1" : "⠁",
    "busy-2" : "⠃",
    "busy-3" : "⠇",
    "busy-4" : "⠏",
    "busy-5" : "⠟",
    "busy-6" : "⠿",
    }

def yearday(date):
    return (datetime.date(date.year,date.month,date.day) -
            datetime.date(date.year, 1, 1)).days + 1

def daterange(start, end):
    for n in range(int ((end - start).days)+1):
        yield start + datetime.timedelta(n)

def is_today(year, month, day):
    return datetime.date(year, month, day) == datetime.date.today()

def is_weekend(year, month, day):
    return datetime.date(year, month, day).weekday() in [5,6]

def is_vacant(year, month, day):
    return datetime.date(year, month, day) in personal_holidays

# def is_busy(year, month, day):
#     date = datetime.datetime(year, month, day)
#     return busydays[yearday(date)]

# def is_deadline(year, month, day):
#     date = datetime.datetime(year, month, day)
#     return yearday(date) in deadlines

def format_month(year, month):
    day_names   = [day[:2] for day in list(calendar.day_name)]
    month_names = list(calendar.month_name)[1:]
    width = 7*3-1

    lines = [""]*8

    # Month name
    # ----------
    name = month_names[month-1]
    lines[0] = color["month"] + name.center(width) + color["reset"] + " "

    # Week day names
    # --------------
    s = color["week"]
    for name in day_names[:5]: s += name + " "
    s += color["reset"] + color["weekend"]
    for name in day_names[5:]: s += name + " "
    s += color["reset"]
    lines[1] = s

    # Week days
    # ---------
    first = calendar.weekday(year, month, 1)
    last = calendar.monthrange(year, month)[1]

    for line in range(6):
        s = ""
        for column in range(7):
            day = line*7 + column - first + 1
            if day < 1 or day > last:
                s += "   "
            else:
                c = ""  # c for (c)olor ?
                # c += color["busy-" + str( min(is_busy(year, month, day),4))]
                if is_weekend(year, month, day):
                    c += color["weekend"]
                else:
                    c += color["week"]
                if is_today(year, month, day):
                    c += color["today"]
                if is_vacant(year, month, day):
                    c += color["vacant"]
                s += c + "%2d" % day
                s += color["reset"]
                # if is_deadline(year, month, day):
                #     s += color["deadline"] + "!"
                # else:
                #     s += markers["busy-" + str(min(is_busy(year, month, day),6))]
                s += color["reset"]
        lines[2+line] = s

    return lines

def printAgenda():
       n = 4
       lines = []
       print("\033[2J\033[H") # clear terminal
       print("Today:", today)
       for month in range(1, 13, n):
           months = [format_month(current_year, month+i) for i in range(n)]
           for i in range(8):
               line = ""
               for j in range(n):
                   line += months[j][i] + " "
               lines.append(line)
           lines.append("\033[0m")
       for line in lines: print(" "+line)

printAgenda()
