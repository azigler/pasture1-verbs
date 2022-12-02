#27:union   this none this rxd

"Returns the set union of all of the lists provided as arguments.";
if (!args)
  return {};
endif
{set, @rest} = args;
for l in (rest)
  for x in (l)
    set = setadd(set, x);
  endfor
endfor
return set;
