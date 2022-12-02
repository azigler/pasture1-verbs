#26:factorial   this none this rxd

"factorial(INT n) -- returns n factorial for 0 <= n (<= 12).";
if ((number = args[1]) < 0)
  return E_INVARG;
elseif (typeof(number) != INT)
  return E_TYPE;
endif
fact = 1;
for i in [2..number]
  fact = fact * i;
endfor
return fact;
