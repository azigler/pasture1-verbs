#26:sum_float   this none this rxd

":sum_float(FLOAT num, num, num ...) => Total of all arguments added together.";
":sum_float({num, num, num, ...}) will also work.";
{?total = 0.0, @rest} = args;
if (typeof(total) == LIST)
  {?total = 0.0, @rest} = total;
endif
for number in (rest)
  total = total + number;
endfor
return total;
