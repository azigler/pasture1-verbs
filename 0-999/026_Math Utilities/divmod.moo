#26:divmod   this none this rxd

"divmod(INT n, INT d) => {q,r} such that n = dq + r";
"  handles negative numbers correctly   0<=r<d if d>0, -d<r<=0 if d<0.";
{n, d} = args;
if (typeof(n) != INT && typeof(d) != INT)
  return E_TYPE;
endif
r = (n % d + d) % d;
q = (n - r) / d;
return {q, r};
