#27:equal   this none this rxd

"True if the two lists given contain the same elements.";
"False otherwise.";
{set1, set2} = args;
while (set1)
  {elt, @set1} = set1;
  if (elt in set2)
    set2 = setremove(set2, elt);
    while (elt in set2)
      set2 = setremove(set2, elt);
    endwhile
    while (elt in set1)
      set1 = setremove(set1, elt);
    endwhile
  else
    return 0;
  endif
endwhile
if (set2)
  return 0;
else
  return 1;
endif
