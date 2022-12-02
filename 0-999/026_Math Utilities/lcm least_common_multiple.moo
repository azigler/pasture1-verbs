#26:"lcm least_common_multiple"   this none this rxd

"lcm(INT num1,INT num2): find the least common multiple of the two numbers.";
"we shall use the positive lcm value without loss of generality.";
"since we have gcd already, we'll just use lcm*gcd = num1*num2";
num1 = abs(args[1]);
num2 = abs(args[2]);
return num1 * num2 / this:gcd(num1, num2);
