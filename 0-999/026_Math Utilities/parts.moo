#26:parts   this none this rxd

"parts(INT n, INT q [,INT i]) -- returns a decomposition of n by q into integer and floating point parts with i = the number of digits after the decimal.";
"i defaults to 5.";
"warning: it is quite easy to hit maxint which results in unpredictable";
"         results";
{n, q, ?i = 5} = args;
if (typeof(n) != INT && typeof(q) != INT && typeof(i) != INT)
  return E_TYPE;
endif
parts = {n / q, n % q};
return {parts[1], parts[2] * 10 ^ i / q};
