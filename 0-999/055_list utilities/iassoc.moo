#55:iassoc   this none this rxd

"Copied from Moo_tilities (#332):iassoc by Mooshie (#106469) Wed Mar 18 19:27:51 1998 PST";
"Usage: iassoc(ANY target, LIST list [, INT index ]) => Returns the index of the first element of `list' whose own index-th element is target.  Index defaults to 1.";
"Returns 0 if no such element is found.";
{target, thelist, ?indx = 1} = args;
for element in (thelist)
  if (`element[indx] == target ! E_RANGE, E_TYPE => 0')
    if (typeof(element) == LIST)
      return element in thelist;
    endif
  endif
endfor
return 0;
