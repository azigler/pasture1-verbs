#26:xcos   this none this rxd

"xcos(INT x) -- calculates the taylor approximation for the cosine function";
if (typeof(x = args[1]) != INT)
  return E_TYPE;
endif
if (x * x > this.taylor)
  return (this:xcos(x / 2) * this:xcos((x + 1) / 2) - this:xsin(x / 2) * this:xsin((x + 1) / 2)) / 10000;
else
  return (1000000000 - x * x * (152309 + 4 * x * x)) / 100000;
endif
