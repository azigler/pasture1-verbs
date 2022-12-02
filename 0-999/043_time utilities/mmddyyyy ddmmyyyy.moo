#43:"mmddyyyy ddmmyyyy"   this none this rxd

"Given a time() or ctime()-style date and an optional separator, this returns the MM/DD/YYYY or DD/MM/YYYY form of the date (depending on the verb called.)  The default seperator is '/'";
{time, ?divstr = "/"} = args;
if (typeof(time) == INT)
  time = ctime(time);
elseif (typeof(time) != STR)
  return E_TYPE;
endif
date = $string_utils:explode(time);
day = toint(date[3]);
month = date[2] in $time_utils.monthabbrs;
year = date[5];
daystr = day < 10 ? "0" + tostr(day) | tostr(day);
monthstr = month < 10 ? "0" + tostr(month) | tostr(month);
yearstr = tostr(year);
if (verb == "mmddyyyy")
  return tostr(monthstr, divstr, daystr, divstr, yearstr);
else
  return tostr(daystr, divstr, monthstr, divstr, yearstr);
endif
