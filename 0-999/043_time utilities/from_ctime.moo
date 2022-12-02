#43:from_ctime   this none this rxd

"Given a string such as returned by ctime(), return the corresponding time-in-seconds-since-1970 time returned by time(), or E_DIV if the format is wrong in some essential way.";
words = $string_utils:explode(args[1]);
if (length(words) == 5)
  "Arrgh!  the old ctime() didn't return a time zone, yet it arbitrarily decides whether it's standard or daylight savings time.  URK!!!!!";
  words = listappend(words, "PST");
endif
if (length(words) != 6 || length(hms = $string_utils:explode(words[4], ":")) != 3 || !(month = words[2] in this.monthabbrs) || !(zone = $list_utils:assoc(words[6], this.timezones)))
  return E_DIV;
endif
year = toint(words[5]);
day = {-1, 30, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}[month] + toint(words[3]) + year * 366;
zone = zone[2];
return (((day - (day + 1038) / 1464 - (day + 672) / 1464 - (day + 306) / 1464 - (day + 109740) / 146400 - (day + 73140) / 146400 - (day + 36540) / 146400 - 719528) * 24 + toint(hms[1]) + zone) * 60 + toint(hms[2])) * 60 + toint(hms[3]);
