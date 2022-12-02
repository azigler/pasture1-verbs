#20:from_seconds   this none this rxd

":from_seconds(number of seconds) => returns a string containing the rough increment of days, or hours if less than a day, or minutes if less than an hour, or lastly in seconds.";
":from_seconds(86400) => \"a day\"";
":from_seconds(7200)  => \"two hours\"";
minute = 60;
hour = 60 * minute;
day = 24 * hour;
secs = args[1];
if (secs > day)
  count = secs / day;
  unit = "day";
  article = "a";
elseif (secs > hour)
  count = secs / hour;
  unit = "hour";
  article = "an";
elseif (secs > minute)
  count = secs / minute;
  unit = "minute";
  article = "a";
else
  count = secs;
  unit = "second";
  article = "a";
endif
if (count == 1)
  time = tostr(article, " ", unit);
else
  time = tostr(count, " ", unit, "s");
endif
return time;
