#26:"gcd greatest_common_divisor"   this none this rxd

"gcd(INT num1,INT num2): find the greatest common divisor of the two numbers";
"using the division algorithm. the absolute values of num1 and num2 are";
"used without loss of generality.";
num1 = abs(args[1]);
num2 = abs(args[2]);
max = max(num1, num2);
min = min(num1, num2);
if (r1 = max % min)
  while (r2 = min % r1)
    min = r1;
    r1 = r2;
  endwhile
  return r1;
else
  return min;
endif
