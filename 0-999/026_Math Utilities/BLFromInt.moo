#26:BLFromInt   this none this rxd

"BlFromInt(INT x) => converts the number provided into a 32 bit binary number, which is returned via a 32 element LIST of 1's and 0's. Note that this verb was originally written to be used with the $math_utils verbs: AND, NOT, OR, XOR, but has since been taken out of them.";
if (typeof(x = args[1]) != INT)
  return E_TYPE;
endif
l = {};
firstbit = x < 0;
if (firstbit)
  x = x + $minint;
endif
for i in [1..31]
  l = {x % 2, @l};
  x = x / 2;
endfor
return {firstbit, @l};
