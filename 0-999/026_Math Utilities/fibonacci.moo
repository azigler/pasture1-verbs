#26:fibonacci   this none this rxd

"fibonacci(INT n) -- calculates the fibonacci numbers to the nth term";
"and returns them in a list. n must be >= 0.";
if (typeof(n = args[1]) != INT)
  return E_TYPE;
elseif (n < 0)
  return E_INVARG;
elseif (n == 0)
  return {0};
else
  x = {0, 1};
  for i in [2..n]
    x = {@x, x[$ - 1] + x[$]};
  endfor
  return x;
endif
