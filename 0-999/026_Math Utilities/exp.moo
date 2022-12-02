#26:exp   this none this rxd

"exp(INT|FLOAT x[,INT n]) -- calculates an nth order taylor approximation for e^x.";
"n defaults to 5. Any n given must be >= 0. you need to divide the result";
"the answer will be returned as {integer part,fractional part} if the input x was an integer. If it is floating point, so will the answer (and this uses the builtin function.)";
{x, ?n = 5} = args;
if (typeof(x) == FLOAT)
  return exp(x);
elseif (typeof(x) != INT && typeof(n) != INT)
  return E_TYPE;
endif
ex = nfact = 1;
for i in [0..n - 1]
  j = n - i;
  ex = ex * x + (nfact = nfact * j);
endfor
return this:parts(ex, nfact);
