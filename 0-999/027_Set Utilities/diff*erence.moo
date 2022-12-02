#27:diff*erence   this none this rxd

"Usage:  diff(set 1, set 2, ..., set n)";
"Returns all elements of set 1 that are not in sets 2..n";
{set, @rest} = args;
for l in (rest)
  for x in (l)
    set = setremove(set, x);
  endfor
endfor
return set;
