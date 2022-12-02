#26:mod   this none this rxd

"A correct mod function.";
"mod(INT n, INT d) => r such that n = dq + r and (0<=r<d if d>0 or -d<r<=0 if d<0).";
{n, d} = args;
if (typeof(n) != INT && typeof(d) != INT)
  return E_TYPE;
endif
return (n % d + d) % d;
