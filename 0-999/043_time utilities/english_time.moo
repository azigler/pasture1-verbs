#43:english_time   this none this rxd

"english_time(time [,reference time]): returns the time as a string of";
"years, months, days, hours, minutes and seconds using the reference time as";
"the start time and incrementing forwards. it can be given in either ctime()";
"or time() format. if a reference time is not given, it is set to time().";
{_time, ?reftime = time()} = args;
if (_time < 1)
  return "0 seconds";
endif
_ctime = typeof(reftime) == INT ? ctime(reftime) | reftime;
seclist = {60, 60, 24};
units = {"year", "month", "day", "hour", "minute", "second"};
timelist = {};
for unit in (seclist)
  timelist = {_time % unit, @timelist};
  _time = _time / unit;
endfor
months = 0;
month = _ctime[5..7] in $time_utils.monthabbrs;
year = toint(_ctime[21..24]);
"attribution: the algorithm used is from the eminently eminent g7.";
while (_time >= (days = this.monthlens[month] + (month == 2 && year % 4 == 0 && !(year % 400 in {100, 200, 300}))))
  _time = _time - days;
  months = months + 1;
  if ((month = month + 1) > 12)
    year = year + 1;
    month = 1;
  endif
  if (months > 2400)
    return tostr(">", months / 12, " years");
  endif
  $command_utils:suspend_if_needed(0);
endwhile
timelist = {months / 12, months % 12, _time, @timelist};
for unit in (units)
  i = unit in units;
  if (timelist[i] > 0)
    units[i] = tostr(timelist[i]) + " " + units[i] + (timelist[i] == 1 ? "" | "s");
  else
    units = listdelete(units, i);
    timelist = listdelete(timelist, i);
  endif
endfor
return $string_utils:english_list(units);
