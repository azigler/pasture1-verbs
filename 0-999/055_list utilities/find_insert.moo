#55:find_insert   this none this rxd

"find_insert(sortedlist,key) => index of first element in sortedlist > key";
"  sortedlist is assumed to be sorted in increasing order and the number returned is anywhere from 1 to length(sortedlist)+1, inclusive.";
{lst, key} = args;
if ((r = length(lst)) < 25)
  for l in [1..r]
    if (lst[l] > key)
      return l;
    endif
  endfor
  return r + 1;
else
  l = 1;
  while (r >= l)
    if (key < lst[i = (r + l) / 2])
      r = i - 1;
    else
      l = i + 1;
    endif
  endwhile
  return l;
endif
