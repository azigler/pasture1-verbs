#20:ordinal   this none this rxd

":short_ordinal(1) => \"1st\",:short_ordinal(2) => \"2nd\",etc...";
string = tostr(n = args[1]);
n = abs(n) % 100;
if (n / 10 != 1 && n % 10 in {1, 2, 3})
  return string + {"st", "nd", "rd"}[n % 10];
else
  return string + "th";
endif
