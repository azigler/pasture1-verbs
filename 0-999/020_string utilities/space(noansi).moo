#20:space(noansi)   this none this rxd

"space(len,fill) returns a string of length abs(len) consisting of copies of fill.  If len is negative, fill is anchored on the right instead of the left.";
{n, ?fill = " "} = args;
if (typeof(n) == STR)
  n = length(n);
endif
if (n > 1000)
  "Prevent someone from crashing the moo with $string_utils:space($maxint)";
  return E_INVARG;
endif
if (" " != fill)
  fill = fill + fill;
  fill = fill + fill;
  fill = fill + fill;
elseif ((n = abs(n)) < 70)
  return "                                                                      "[1..n];
else
  fill = "                                                                      ";
endif
m = (n - 1) / length(fill);
while (m)
  fill = fill + fill;
  m = m / 2;
endwhile
return n > 0 ? fill[1..n] | fill[$ + 1 + n..$];
