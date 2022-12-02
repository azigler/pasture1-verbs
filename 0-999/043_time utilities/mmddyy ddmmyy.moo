#43:"mmddyy ddmmyy"   this none this rxd

"Copied from Archer (#52775):mmddyy Tue Apr  6 17:04:26 1993 PDT";
"Given a time() or ctime()-style date and an optional separator, this returns the MM/DD/YY or DD/MM/YY form of the date (depending on the verb called.)  The default seperator is '/'";
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
yearstr = tostr(year)[3..4];
if (verb == "mmddyy")
  return tostr(monthstr, divstr, daystr, divstr, yearstr);
else
  return tostr(daystr, divstr, monthstr, divstr, yearstr);
endif
