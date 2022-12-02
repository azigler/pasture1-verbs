#55:"longest shortest"   this none this rxd

"Copied from APHiD (#33119):longest Sun May  9 21:00:18 1993 PDT";
"$list_utils:longest(<list>)";
"$list_utils:shortest(<list>)";
"             - Returns the shortest or longest element in the list.  Elements may be either strings or lists.  Returns E_TYPE if passed a non-list or a list containing non-string/list elements.  Returns E_RANGE if passed an empty list.";
if (typeof(all = args[1]) != LIST)
  return E_TYPE;
elseif (all == {})
  return E_RANGE;
else
  result = all[1];
  for things in (all)
    if (typeof(things) != LIST && typeof(things) != STR)
      return E_TYPE;
    else
      result = verb == "longest" && length(result) < length(things) || (verb == "shortest" && length(result) > length(things)) ? things | result;
    endif
  endfor
endif
return result;
