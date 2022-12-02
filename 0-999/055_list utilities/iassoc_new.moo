#55:iassoc_new   this none this rxd

"Copied from Moo_tilities (#332):iassoc_new by Mooshie (#106469) Wed Mar 18 19:27:52 1998 PST";
"Usage: iassoc_new(ANY target, LIST list [, INT index ]) => Returns the index of the first element of `list' whose own index-th element is target.  Index defaults to 1.";
"Returns 0 if no such element is found.";
"NOTE: expects that each index in the given list will be a list with at least as many elements as the indicated `index' argument. Otherwise will return E_RANGE";
{target, thelist, ?indx = 1} = args;
try
  for element in (thelist)
    if (element[indx] == target)
      if (typeof(element) == LIST)
        return element in thelist;
      endif
    endif
  endfor
except e (ANY)
  return e[1];
endtry
return 0;
