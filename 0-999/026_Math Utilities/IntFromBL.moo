#26:IntFromBL   this none this rxd

"IntFromBl(LIST of 1's and 0's) => converts the 32 bit binary representation given by the list of 1's and 0's and converts it to a normal decimal number. Note that this verb was originally written to be used with the $math_utils verbs: AND, NOT, OR, XOR, but has since been taken out of them.";
bl = args[1];
x = 0;
for l in (bl)
  x = x * 2;
  x = x + l;
endfor
return x;
