#55:iassoc_sorted   this none this rxd

"iassoc_sorted(target,sortedlist[,i]) => index of last element in sortedlist whose own i-th element is <= target.  i defaults to 1.";
"  sortedlist is assumed to be sorted in increasing order and the number returned is anywhere from 0 to length(sortedlist), inclusive.";
{target, lst, ?indx = 1} = args;
if ((r = length(lst)) < 25)
  for l in [1..r]
    if (target < lst[l][indx])
      return l - 1;
    endif
  endfor
  return r;
else
  l = 0;
  r = r + 1;
  while (r - 1 > l)
    if (target < lst[i = (r + l) / 2][indx])
      r = i;
    else
      l = i;
    endif
  endwhile
  return l;
endif
