#26:random_range   this none this rxd

"random_range(INT range [,INT mean]): returns a random integer within the given range from the mean. if the mean isn't given, it defaults to 0";
"e.g., random_range(10) => -10..10";
"      random_range(10,4) => -6..14";
{range, ?mean = 0} = args;
if (typeof(range) != INT && typeof(mean) != INT)
  return E_TYPE;
endif
return mean + (random(2) == 1 ? -1 | 1) * this:random(range);
