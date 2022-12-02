#46:_parse_date   this none this rxd

words = $string_utils:explode(args[1], "-");
if (length(words) == 1)
  if (index("yesterday", words[1]) == 1)
    time = $time_utils:dst_midnight(time() - time() % 86400 - 86400);
  elseif (index("today", words[1]) == 1)
    time = $time_utils:dst_midnight(time() - time() % 86400);
  elseif (typeof(time = $time_utils:from_day(words[1], -1)) == ERR)
    time = "weekday, `Today', `Yesterday', or date expected.";
  endif
elseif (!words || (length(words) > 3 || (!toint(words[1]) || E_TYPE == (year = $code_utils:toint({@words, "-1"}[3])))))
  time = "Date should be of the form `5-Jan', `5-Jan-92', `Wed',`Wednesday'";
else
  day = toint(words[1]);
  time = $time_utils:dst_midnight($time_utils:from_month(words[2], -1, day));
  if (length(words) == 3)
    thisyear = toint(ctime(time)[21..24]);
    if (100 > year)
      year = thisyear + 50 - (thisyear - year + 50) % 100;
    endif
    time = $time_utils:dst_midnight($time_utils:from_month(words[2], year - thisyear - (year <= thisyear), day));
  endif
endif
return time;
