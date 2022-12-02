#26:random   this none this rxd

"random(INT n): returns a random integer in the following manner:";
"random(n > 0) will return a integer in the range 0 to n";
"random(n < 0) will return a integer in the range n to 0";
if (typeof(prob = args[1]) != INT)
  return E_TYPE;
endif
mod = prob < 0 ? -1 | 1;
return mod * random(abs(prob + mod)) - mod;
