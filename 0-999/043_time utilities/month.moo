#43:month   none none none rxd

"Given a time() or ctime()-style date, this returns the full name";
"of the month.";
if (typeof(args[1]) == INT)
  time = ctime(args[1]);
elseif (typeof(args[1]) == STR)
  time = args[1];
else
  return E_TYPE;
endif
monthabbr = $string_utils:explode(time)[2];
return this.months[monthabbr in this.monthabbrs];
