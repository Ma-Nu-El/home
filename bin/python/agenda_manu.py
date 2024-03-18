#!/usr/bin/env python3

import os                # for tilde expansion
import sys               # to read input
import holidays
import calendar
import datetime
import orgparse
import logging

logging_level=logging.ERROR         # select debug level
logging_format='%(asctime)s - %(levelname)s - %(message)s'
logging.basicConfig(level=logging_level, format=logging_format)
# logging.disable(logging.DEBUG)    # disable only DEBUG messages
# logging.disable(logging.INFO)     # disable INFO and upwards
# logging.disable(logging.WARNING)  # disable WARNING and upwards
# logging.disable(logging.ERROR)    # disable ERROR and upwards
# logging.disable(logging.CRITICAL) # disable all logging messsages


current_year = datetime.datetime.now().year
today = datetime.date.today()

class PersonalHolidays(holidays.Chile):
     def _populate(self, year):
         holidays.Chile._populate(self, year)
         # National holidays
         self[datetime.date(2024, 1, 1)]   = "Holiday Name"
         self[datetime.date(2024, 3, 29)]  = "Holiday Name"
         self[datetime.date(2024, 3, 30)]  = "Holiday Name"
         self[datetime.date(2024, 5, 1)]   = "Holiday Name"
         self[datetime.date(2024, 5, 21)]  = "Holiday Name"
         self[datetime.date(2024, 6, 9)]   = "Holiday Name"
         self[datetime.date(2024, 6, 20)]  = "Holiday Name"
         self[datetime.date(2024, 6, 29)]  = "Holiday Name"
         self[datetime.date(2024, 7, 16)]  = "Holiday Name"
         self[datetime.date(2024, 8, 15)]  = "Holiday Name"
         self[datetime.date(2024, 9, 18)]  = "Holiday Name"
         self[datetime.date(2024, 9, 19)]  = "Holiday Name"
         self[datetime.date(2024, 9, 20)]  = "Holiday Name"
         self[datetime.date(2024, 10, 12)] = "Holiday Name"
         self[datetime.date(2024, 10, 27)] = "Holiday Name"
         self[datetime.date(2024, 10, 31)] = "Holiday Name"
         self[datetime.date(2024, 11, 1)]  = "Holiday Name"
         self[datetime.date(2024, 11, 24)] = "Holiday Name"
         self[datetime.date(2024, 12, 8)]  = "Holiday Name"
         self[datetime.date(2024, 12, 25)] = "Holiday Name"
         # University holydays and vacations
         self[datetime.date(2024, 1, 29)] = "Holiday Name"
         self[datetime.date(2024, 1, 30)] = "Holiday Name"
         self[datetime.date(2024, 1, 31)] = "Holiday Name"
         self[datetime.date(2024, 2, 1)] = "Holiday Name"
         self[datetime.date(2024, 2, 2)] = "Holiday Name"
         self[datetime.date(2024, 2, 5)] = "Holiday Name"
         self[datetime.date(2024, 2, 6)] = "Holiday Name"
         self[datetime.date(2024, 2, 7)] = "Holiday Name"
         self[datetime.date(2024, 2, 8)] = "Holiday Name"
         self[datetime.date(2024, 2, 9)] = "Holiday Name"
         self[datetime.date(2024, 2, 12)] = "Holiday Name"
         self[datetime.date(2024, 2, 13)] = "Holiday Name"
         self[datetime.date(2024, 2, 14)] = "Holiday Name"
         self[datetime.date(2024, 2, 15)] = "Holiday Name"
         self[datetime.date(2024, 2, 16)] = "Holiday Name"
         self[datetime.date(2024, 2, 19)] = "Holiday Name"
         self[datetime.date(2024, 2, 20)] = "Holiday Name"
         self[datetime.date(2024, 2, 21)] = "Holiday Name"
         self[datetime.date(2024, 2, 22)] = "Holiday Name"
         self[datetime.date(2024, 2, 23)] = "Holiday Name"
         self[datetime.date(2024, 5, 6)] = "Holiday Name"
         self[datetime.date(2024, 5, 7)] = "Holiday Name"
         self[datetime.date(2024, 5, 8)] = "Holiday Name"
         self[datetime.date(2024, 5, 9)] = "Holiday Name"
         self[datetime.date(2024, 5, 10)] = "Holiday Name"
         self[datetime.date(2024, 5, 20)] = "Holiday Name"
         self[datetime.date(2024, 6, 21)] = "Holiday Name"
         self[datetime.date(2024, 7, 22)] = "Holiday Name"
         self[datetime.date(2024, 7, 23)] = "Holiday Name"
         self[datetime.date(2024, 7, 24)] = "Holiday Name"
         self[datetime.date(2024, 7, 25)] = "Holiday Name"
         self[datetime.date(2024, 7, 26)] = "Holiday Name"
         self[datetime.date(2024, 8, 16)] = "Holiday Name"
         self[datetime.date(2024, 9, 16)] = "Holiday Name"
         self[datetime.date(2024, 9, 17)] = "Holiday Name"
         self[datetime.date(2024, 10, 3)] = "Holiday Name"
         self[datetime.date(2024, 12, 23)] = "Holiday Name"
         self[datetime.date(2024, 12, 24)] = "Holiday Name"
         self[datetime.date(2024, 12, 25)] = "Holiday Name"
         self[datetime.date(2024, 12, 26)] = "Holiday Name"
         self[datetime.date(2024, 12, 27)] = "Holiday Name"
         self[datetime.date(2024, 12, 28)] = "Holiday Name"
         self[datetime.date(2024, 12, 29)] = "Holiday Name"
         self[datetime.date(2024, 12, 30)] = "Holiday Name"
         self[datetime.date(2024, 12, 31)] = "Holiday Name"


personal_holidays = PersonalHolidays()


# Colors for displaying things
color = { "month"     : "\033[0m" ,
          "week"      : "\033[0m"   ,
          "weekend"   : "\033[0;2m" ,
          "busy-0"    : "\033[0m"      ,
          "personal"  : "\033[0;31m" ,
          "deadline"  : "\033[0;1;31m" ,
          "scheduled" : "\033[0;1;32m" ,
          "today"     : "\033[0;43m" ,
          "reset"     : "\033[0m"
         }

markers = {
    "busy-0" : " ",
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

def is_busy(year, month, day):
    date = datetime.datetime(year, month, day)
    return busydays[yearday(date)]

def is_personal(year, month, day):
    return datetime.date(year, month, day) in personal_holidays

def is_deadline(year, month, day):
    date = datetime.datetime(year, month, day)
    return yearday(date) in deadlines

def is_scheduled(year, month, day):
    date = datetime.datetime(year, month, day)
    return yearday(date) in schedules

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
                c += color["busy-" + str( min(is_busy(year, month, day),0))]
                if is_weekend(year, month, day):
                    c += color["weekend"]
                else:
                    c += color["week"]
                if is_today(year, month, day):
                    c += color["today"]
                if is_personal(year, month, day):
                    c += color["personal"]
                s += c + "%2d" % day
                # s += color["reset"]

                if is_scheduled(year, month, day):
                    s += color["scheduled"] + "!"
                elif is_deadline(year, month, day):
                    s += color["deadline"] + "!"
                else:
                    s += markers["busy-" + str(min(is_busy(year, month, day),0))]
                s += color["reset"]
        lines[2+line] = s

    return lines

# Fill in busy days from agenda.org
busydays = { i:0 for i in range(366+1) }
schedules = set()
deadlines = set()
# events = []

def readFile(agenda_files):

    logging.debug(f"Agenda files file  : {agenda_files}")

    with open(agenda_files, 'r') as file:

        for line in file:
            line = line.strip()
            logging.debug(f"Line read  : {line}")

            if not line.startswith(";"):

                logging.debug(f"Line not ignored  : {line}")
                full_path = os.path.expanduser(line)
                agenda = orgparse.load(full_path)

                for node in agenda:

                    if hasattr(node, "datelist") and node.datelist:
                        for date in node.datelist:
                            d = date.start
                            d = datetime.date(d.year, d.month, d.day)
                            busydays[yearday(d)] += 1
                    if hasattr(node, "rangelist") and node.rangelist:
                        for date in node.rangelist:
                            ds, de = date.start, date.end
                            ds = datetime.date(ds.year, ds.month, ds.day)
                            de = datetime.date(de.year, de.month, de.day)
                            for i, d in enumerate(daterange(ds, de)):
                                busydays[yearday(d)] += 1
                    if hasattr(node, "scheduled") and node.scheduled:
                        s = node.scheduled.start
                        s = datetime.date(s.year, s.month, s.day)
                        schedules.add(yearday(s))
                    if hasattr(node, "deadline") and node.deadline:
                        d = node.deadline.start
                        d = datetime.date(d.year, d.month, d.day)
                        deadlines.add(yearday(d))

def printAgenda():
    month_per_row = 4
    lines = []
    print("\033[2J\033[H") # clear terminal
    print("Calendar for year: ", current_year, "| Today : ", today)
    for month in range(1, 13, month_per_row):
        months = [format_month(current_year, month+i) for i in range(month_per_row)]
        for i in range(8):
            line = ""
            for j in range(month_per_row):
                line += months[j][i] + " "
            lines.append(line)
        lines.append("\033[0m")
    for line in lines: print(" "+line)


agenda_files="~/agenda-files.txt"

agenda_files_path = os.path.expanduser(agenda_files)

readFile(agenda_files_path)
printAgenda()
