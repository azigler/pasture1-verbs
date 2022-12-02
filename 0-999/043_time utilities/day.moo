#43:day   none none none rxd

"Given a time() or ctime()-style date, this returns the full name of the day.";
if (typeof(args[1]) == INT)
  time = ctime(args[1]);
elseif (typeof(args[1]) == STR)
  time = args[1];
else
  return E_TYPE;
endif
dayabbr = $string_utils:explode(time)[1];
return this.days[dayabbr in this.dayabbrs];
