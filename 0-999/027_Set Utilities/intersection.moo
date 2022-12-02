#27:intersection   this none this rxd

"Returns the set intersection of all the lists provided as arguments.";
if (!args)
  return {};
endif
max = 0;
{result, @rest} = args;
for set in (rest)
  if (length(result) < length(set))
    set1 = result;
    set2 = set;
  else
    set1 = set;
    set2 = result;
  endif
  for x in (set1)
    if (!(x in set2))
      set1 = setremove(set1, x);
    endif
  endfor
  result = set1;
endfor
return result;
