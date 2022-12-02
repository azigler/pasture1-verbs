#43:ampm   none none none rxd

"Return a time in the form [h]h[:mm[:ss]] {a.m.|p.m.}.  Args are";
"[1]   either a time()- or a ctime()-style date, and";
"[2]   (optional) the precision desired--1 for hours, 2 for minutes,";
"        3 for seconds.  If not given, precision defaults to minutes";
{time, ?precision = 2} = args;
if (typeof(time) == INT)
  time = ctime(time);
elseif (typeof(time) != STR)
  return E_TYPE;
endif
time = $string_utils:explode(time)[4];
hour = toint(time[1..2]);
if (hour == 0)
  time = "12" + time[3..precision * 3 - 1] + " a.m.";
elseif (hour == 12)
  time = time[1..precision * 3 - 1] + " p.m.";
elseif (hour > 12)
  time = tostr(hour - 12) + time[3..precision * 3 - 1] + " p.m.";
else
  time = tostr(hour) + time[3..precision * 3 - 1] + " a.m.";
endif
return time;
