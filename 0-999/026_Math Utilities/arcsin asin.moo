#26:"arcsin asin"   this none this rxd

"Copied from Trig_Utils (#25800):arcsin by Obvious (#54879) Fri Nov 17 06:08:01 1995 PST";
{given} = args;
if (typeof(given) == FLOAT)
  return asin(given);
endif
given = abs(given);
if (given > 10000)
  return E_RANGE;
endif
i = 1;
while (given > this.sines[i])
  i = i + 1;
endwhile
if (given == this.sines[i])
  if (args[1] < 0)
    return {-i, 0};
  else
    return {i, 0};
  endif
endif
degrees = i - 1;
if (i == 1)
  lower = 0;
else
  lower = this.sines[i - 1];
endif
upper = this.sines[i];
delta1 = given - lower;
delta2 = upper - lower;
minutes = (delta1 * 60 + (delta2 + 1) / 2) / delta2;
if (args[1] < 0)
  degrees = -degrees;
  minutes = -minutes;
endif
return {degrees, minutes};
