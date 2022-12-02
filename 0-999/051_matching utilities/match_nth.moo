#51:match_nth   this none this rxd

":match_nth(string, objlist, n)";
"Find the nth object in 'objlist' that matches 'string'.";
{what, where, n} = args;
for v in (where)
  z = 0;
  for q in (v.aliases)
    z = z || index(q, what) == 1;
  endfor
  if (z && !(n = n - 1))
    return v;
  endif
endfor
return $failed_match;
