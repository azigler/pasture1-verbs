#26:geometric   this none this rxd

"geometric(INT|FLOAT x [,INT n]) -- calculates the value of the geometric series at x to the nth term. i.e., approximates 1/(1-x) when |x| < 1. This, of course, is impossible in MOO, but someone may find it useful in some way.";
"n defaults to 5. n must be >= 0.";
"This verb was revised on 2006-03-16 by Gary (#110811) to allow for floating point input of the first argument.  The help documentation had said this was allowed but actually it caused a traceback.  How many people are actually using this, I wonder? ";
{n, ?order = 5} = args;
if (!(typeof(n) in {INT, FLOAT}) || typeof(order) != INT)
  return E_TYPE;
elseif (order <= 0)
  return E_INVARG;
endif
x = typeof(n) == FLOAT ? 1.0 | 1;
for i in [1..order]
  x = x + n ^ i;
endfor
return x;
