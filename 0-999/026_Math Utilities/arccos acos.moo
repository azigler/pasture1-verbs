#26:"arccos acos"   this none this rxd

"Copied from Trig_Utils (#25800):arccos by Obvious (#54879) Fri Nov 17 06:08:08 1995 PST";
given = args[1];
if (typeof(given) == FLOAT)
  return acos(given);
endif
arcsin = this:arcsin(given);
degrees = 89 - arcsin[1];
minutes = 60 - arcsin[2];
"//* Changed (minutes > 60) to (minutes >= 60) following bug report by Loufah (#116455).  2000-03-24 23:00 CST  Gary (#110811).";
if (minutes >= 60)
  minutes = minutes - 60;
  degrees = degrees + 1;
endif
return {degrees, minutes};
