#26:"sum_int sum"   this none this rxd

":sum_int(INT num, num, num ...) => Total of all arguments added together.";
":sum_int({num, num, num, ...}) will also work.";
"(...also named :sum for backward compatibility).";
"Use :sum_float to sum a list of floats.";
{?total = 0, @rest} = args;
if (typeof(total) == LIST)
  {?total = 0, @rest} = total;
endif
for number in (rest)
  total = total + number;
endfor
return total;
"... N.B.  For the sake of backward compatibility this routine will also return the float sum of a non-empty lists of floats, but using it this way should not be encouraged.";
