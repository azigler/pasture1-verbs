#55:flatten_suspended   this none this rxd

"Copied from list utilities (#372):flatten [verb author Hacker (#18105)] at Sun Jul  3 07:46:47 2011 PDT";
"Copied from $quinn_utils (#34283):unroll by Quinn (#19845) Mon Mar  8 09:29:03 1993 PST";
":flatten(LIST list_of_lists) => LIST of all lists in given list `flattened'";
newlist = {};
for elm in (args[1])
  if (typeof(elm) == LIST)
    $command_utils:suspend_if_needed(0);
    newlist = {@newlist, @this:flatten_suspended(elm)};
  else
    $command_utils:suspend_if_needed(0);
    newlist = {@newlist, elm};
  endif
endfor
return newlist;
