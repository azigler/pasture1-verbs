#55:assoc_prefix   this none this rxd

"assoc_prefix(target,list[,index]) returns the first element of `list' whose own index-th element has target as a prefix.  Index defaults to 1.";
{target, thelist, ?indx = 1} = args;
for t in (thelist)
  if (typeof(t) == LIST && (length(t) >= indx && index(t[indx], target) == 1))
    return t;
  endif
endfor
return {};
