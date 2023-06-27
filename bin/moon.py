#!/usr/local/bin/python3
# https://stackoverflow.com/questions/2526815/moon-lunar-phase-algorithm
# - [2023-05-31 Wed 11:25]
import datetime
import ephem
from typing import List, Tuple

def get_phase_on_day(year: int, month: int, day: int):
  """Returns a floating-point number from 0-1. where 0=new, 0.5=full, 1=new"""
  #Ephem stores its date numbers as floating points, which the following uses
  #to conveniently extract the percent time between one new moon and the next
  #This corresponds (somewhat roughly) to the phase of the moon.

  #Use Year, Month, Day as arguments
  date = ephem.Date(datetime.date(year,month,day))

  nnm = ephem.next_new_moon(date)
  pnm = ephem.previous_new_moon(date)

  lunation = (date-pnm)/(nnm-pnm)

  #Note that there is a ephem.Moon().phase() command, but this returns the
  #percentage of the moon which is illuminated. This is not really what we want.

  return lunation

def get_moons_in_year(year: int) -> List[Tuple[ephem.Date, str]]:
  """Returns a list of the full and new moons in a year. The list contains tuples
of either the form (DATE,'full') or the form (DATE,'new')"""
  moons=[]

  date=ephem.Date(datetime.date(year,1,1))
  while date.datetime().year==year:
    date=ephem.next_full_moon(date)
    moons.append( (date,'full') )

  date=ephem.Date(datetime.date(year,1,1))
  while date.datetime().year==year:
    date=ephem.next_new_moon(date)
    moons.append( (date,'new') )

  #Note that previous_first_quarter_moon() and previous_last_quarter_moon()
  #are also methods

  moons.sort(key=lambda x: x[0])

  return moons

print(get_phase_on_day(2013,1,1))

print(get_moons_in_year(2013))
