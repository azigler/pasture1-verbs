#43:from_day   this none this rxd

"from_day(day_of_week,which [,reference time])";
"numeric time (seconds since 1970) corresponding to midnight (PST) of the given weekday.  Use either the name of the day or a 1..7 number (1==Sunday,...)";
"  which==-1 => use most recent such day.";
"  which==+1 => use first upcoming such day.";
"  which==0  => use closest such day.";
"larger (absolute) values for which specify a certain number of weeks into the future or past.";
{day, ?dir = 0, ?reftime = time()} = args;
if (!(toint(day) || (day = $string_utils:find_prefix(day, this.days))))
  return E_DIV;
endif
delta = {288000, 374400, 460800, 547200, 28800, 115200, 201600}[toint(day)];
time = reftime - delta;
if (dir)
  time = time / 604800 + (dir > 0 ? dir | dir + 1);
else
  time = (time + 302400) / 604800;
endif
return time * 604800 + delta;
