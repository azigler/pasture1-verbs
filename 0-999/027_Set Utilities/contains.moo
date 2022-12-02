#27:contains   this none this rxd

"True if the first list given is a superset of all subsequent lists.";
"False otherwise.  {} is a superset of {} and nothing else; anything is";
"a superset of {}.  If only one list is given, return true.";
{?super = {}, @rest} = args;
for l in (rest)
  for x in (l)
    if (!(x in super))
      return 0;
    endif
  endfor
endfor
return 1;
