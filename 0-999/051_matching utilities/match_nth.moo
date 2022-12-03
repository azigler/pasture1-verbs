#51:match_nth   this none this rxd

":match_nth(string, objlist, n)";
"Find the nth object in 'objlist' that matches 'string'.";
{what, where, n} = args;
objs = $string_utils:newmatch(what, where:contents(), 1);
if (objs == #-3)
  return objs;
endif
for v in (objs)
  z = 0;
  for q in ($building_utils:get_aliases(v))
    z = z || index(q, what) == 1;
  endfor
  if (z && !(n = n - 1))
    return v;
  endif
endfor
return $failed_match;
"Last modified Sat Dec  3 10:17:06 2022 UTC by caranov (#133).";
