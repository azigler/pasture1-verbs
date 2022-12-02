#55:flatten   this none this rxd

"Copied from $quinn_utils (#34283):unroll by Quinn (#19845) Mon Mar  8 09:29:03 1993 PST";
":flatten(LIST list_of_lists) => LIST of all lists in given list `flattened'";
newlist = {};
for elm in (args[1])
  if (typeof(elm) == LIST)
    newlist = {@newlist, @this:flatten(elm)};
  else
    newlist = {@newlist, elm};
  endif
endfor
return newlist;
