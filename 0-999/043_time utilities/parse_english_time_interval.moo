#43:parse_english_time_interval   this none this rxd

"$time_utils:parse_english_time_interval(n1,u1,n2,u2,...)";
"or $time_utils:parse_english_time_interval(\"n1 u1[,] [and] n2[,] u2 [and] ...\")";
"There must be an even number of arguments, all of which must be strings,";
" or there must be just one argument which is the entire string to be parsed.";
"The n's are are numeric strings, and the u's are unit names.";
"The known units are in $time_utils.time_units,";
" which must be kept sorted with bigger times at the head.";
"Returns the time represented by those words.";
"For example,";
" $time_utils:parse_english_time_interval(\"30\",\"secs\",\"2\",\"minutes\",\"31\",\"seconds\") => 181";
if (length(args) == 1 && index(args[1], " "))
  return $time_utils:parse_english_time_interval(@$string_utils:words(args[1]));
endif
a = $list_utils:setremove_all(args, "and");
nargs = length(a);
if (nargs % 2)
  return E_ARGS;
endif
nsec = 0;
n = 0;
for i in [1..nargs]
  if (i % 2 == 1)
    if ($string_utils:is_numeric(a[i]))
      n = toint(a[i]);
    elseif (a[i] in {"a", "an"})
      n = 1;
    elseif (a[i] in {"no"})
      n = 0;
    else
      return E_INVARG;
    endif
  else
    unit = a[i];
    if (unit[$] == ",")
      unit = unit[1..$ - 1];
    endif
    ok = 0;
    for entry in ($time_utils.time_units)
      if (!ok && unit in entry[2..$])
        nsec = nsec + entry[1] * n;
        ok = 1;
      endif
    endfor
    if (!ok)
      return E_INVARG;
    endif
  endif
endfor
return nsec;
