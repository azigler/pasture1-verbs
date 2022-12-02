#20:common   this none this rxd

":common(first,second) => length of longest common prefix";
{first, second} = args;
r = min(length(first), length(second));
l = 1;
while (r >= l)
  h = (r + l) / 2;
  if (first[l..h] == second[l..h])
    l = h + 1;
  else
    r = h - 1;
  endif
endwhile
return r;
