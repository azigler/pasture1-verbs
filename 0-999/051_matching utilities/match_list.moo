#51:match_list   this none this rxd

":match_list(string, object_list) -> List of all matches.";
{what, where} = args;
if (!what)
  return {};
endif
r = {};
for v in (where)
  if (!(v in r))
    z = 0;
    for q in (v.aliases)
      z = z || (q && index(q, what) == 1);
    endfor
    if (z)
      "r = listappend(r, v);";
      r = {@r, v};
    endif
  endif
endfor
return r;
"Hydros (#106189) - Sun Jul 3, 2005 - Changed listappend to a splice to save ticks. Old code commented above.";
