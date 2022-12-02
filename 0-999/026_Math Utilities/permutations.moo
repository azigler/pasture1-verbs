#26:permutations   this none this rxd

"permutations(INT n, INT r) -- returns the number of ways possible for one to";
"order r distinct objects given n locations.";
"P(n,r) = n!/(n-r)!";
{n, r} = args;
if (typeof(n) != INT && typeof(r) != INT)
  return E_TYPE;
endif
if (r < 1 || (diff = n - r) < 0)
  return 0;
else
  p = n;
  for i in [diff + 1..n - 1]
    p = p * i;
  endfor
  return p;
endif
