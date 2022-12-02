#26:combinations   this none this rxd

"combinations(INT n, INT r) -- returns the number of ways one can choose r";
"objects from n distinct choices.";
"C(n,r) = n!/[r!(n-r)!]";
"  overflow may occur if n>29...";
{n, r} = args;
if (typeof(n) != INT && typeof(r) != INT)
  return E_TYPE;
endif
if (0 > (r = min(r, n - r)))
  return 0;
else
  c = 1;
  n = n + 1;
  for i in [1..r]
    c = c * (n - i) / i;
  endfor
  return c;
endif
