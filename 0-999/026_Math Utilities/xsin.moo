#26:xsin   this none this rxd

"xsin(INT x) -- calculates the taylor approximation for the sine function";
if (typeof(x = args[1]) != INT)
  return E_TYPE;
endif
if (x * x > this.taylor)
  return (this:xsin(x / 2) * this:xcos((x + 1) / 2) + this:xsin((x + 1) / 2) * this:xcos(x / 2)) / 10000;
else
  return x * (17453000 - x * x * 886) / 100000;
endif
