#!/usr/bin/env python3
# Manuel Fuica Morales
# 2023
# Built on top of work of
# -----------------------------------------------------
# # Copyright 2020 Nicolas P. Rougier - BSD License
#
# # from reading org-mode Emacs files, display a formatted calendar in the
# # terminal showing holidays and busy days and upcoming events.
# -----------------------------------------------------
#
# How does it work currently:
#   Deadlines show with an exclamation point
#   Inactive timestamps shows as an assignment.
#   Scheduled doesn't do anything.
#
#   The more tasks, the more red.
#
# Wanted:
#   Deadline same behavior
#   Inactives don't do anything
#   Scheduled show as assignment.
#   :holiday: tag shows green.
#   - Holiday is just a day.
#   :vacation: tag shows blue.
#   - Vacation is a period.

import sys               # to read input
import holidays
import calendar
import datetime
import orgparse

# Enter user information
user_home="/Users/manuelfuica"
agenda_file="/auxRoam/2024/calendar.org"
current_year=2024
# user_country="Chile"

# Country holidays + Personal holidays
# Import holidays from your country
# and your own holidays.

# class PersonalHolidays(holidays.user_country):
class PersonalHolidays(holidays.Chile):
     def _populate(self, year):
         holidays.Chile._populate(self, year)
         # self[datetime.date(2023, 5, 22)] = "RTT"
         # self[datetime.date(2023, 7, 13)] = "RTT"
personal_holidays = PersonalHolidays()

# Colors for displaying things
color = { "month" :   "\033[1;37;40m",
          "week"  :   "\033[30m",
          "weekend":  "\033[0;2m",
          "vacant":   "\033[0;2m",
          "busy-0"  :   "\033[0m",
          "busy-1"  :   "\033[48;5;223m",
          "busy-2"  :   "\033[48;5;216m",
          "busy-3"  :   "\033[48;5;209m",
          "busy-4"  :   "\033[48;5;202m",
          "deadline": "\033[1;31m",
          "today" :   "\033[1m",
          "reset" :   "\033[0m" }

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

def is_busy(year, month, day):
    date = datetime.datetime(year, month, day)
    return busydays[yearday(date)]

def is_deadline(year, month, day):
    date = datetime.datetime(year, month, day)
    return yearday(date) in deadlines

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
                c = ""
                c += color["busy-" + str( min(is_busy(year, month, day),4))]
                if is_weekend(year, month, day):
                    c += color["weekend"]
                else:
                    c += color["week"]
                if is_today(year, month, day):
                    c += color["today"]
                if is_vacant(year, month, day):
                    c += color["vacant"]
                s += c + "%2d" % day
                # s += color["reset"]
                if is_deadline(year, month, day):
                    s += color["deadline"] + "!"
                else:
                    s += markers["busy-" + str(min(is_busy(year, month, day),6))]
                s += color["reset"]
        lines[2+line] = s

    return lines

# Fill in busy days from agenda.org
busydays = { i:0 for i in range(366+1) }
deadlines = set()
events = []

for filename in [user_home + "/" + agenda_file]: # agenda_file can be a vector
    agenda = orgparse.load(filename)
    for node in agenda:
        if hasattr(node, "datelist") and node.datelist:
            for date in node.datelist:
                d = date.start
                d = datetime.date(d.year,d.month,d.day)
                # busydays.add(yearday(d))
                busydays[yearday(d)] += 1
                events.append([d, None, node.heading, 0, list(node.tags)])

        if hasattr(node, "rangelist") and node.rangelist:
            for date in node.rangelist:
                ds,de = date.start, date.end
                ds = datetime.date(ds.year, ds.month, ds.day)
                de = datetime.date(de.year, de.month, de.day)
                if de > ds:  events.append([ds, de,   node.heading, 0, list(node.tags)])
                else:        events.append([ds, None, node.heading, 0, list(node.tags)])
                for i,d in enumerate(daterange(date.start, date.end)):
                    # busydays.add(yearday(d))
                    busydays[yearday(d)] += 1

        if hasattr(node, "deadline") and node.deadline:
            d = node.deadline.start
            d = datetime.date(d.year,d.month,d.day)
            deadlines.add(yearday(d))
            events.append([d, None, node.heading, 1, list(node.tags)])
        
events.sort(key=lambda data: data[0])


today = datetime.date.today()

# Print agenda (3 months per line)
n = 4
lines = []
print("\033[2J;\033[H") # clear terminal
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

# Print details for upcoming events
print("\033[1;30m Upcoming events (next 2 weeks):")
print(" ───────────────────────────────")
n = 0
for start, stop, heading, deadline, tags in events:
    if today <= start < today+datetime.timedelta(days=28):
        n += 1
        print("\033[0m", end="")
        if deadline:
            print("\033[31m", end="")
        elif start == today:
            print("\033[1;30m", end="")
        if deadline:
            print(" ! ", end="")
        else:
            print("   ", end="")
        if stop is None:
            print("{0}: {1}".format(start, heading), end="")
        else:
            print("{0} to {1}: {2}".format(start, stop, heading), end="")
        if tags: print("\033[2m ({0})".format(tags[0]))
    if n > 21: break
for i in range(22-n):
    print()
