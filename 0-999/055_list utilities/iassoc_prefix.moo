#55:iassoc_prefix   this none this rxd

"iassoc_prefix(target,list[,index]) returns the index of the first element of `list' whose own index-th element has target as a prefix.  Index defaults to 1.";
{target, lst, ?indx = 1} = args;
for i in [1..length(lst)]
  if (typeof(lsti = lst[i]) == LIST && (length(lsti) >= indx && index(lsti[indx], target) == 1))
    return i;
  endif
endfor
return 0;
