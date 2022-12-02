#26:"are_rel_prime are_relatively_prime"   this none this rxd

"are_rel_prime(INT num1,INT num2): returns 1 if num1 and num2 are relatively";
"prime.";
"since we have gcd, this is pretty easy.";
if (this:gcd(args[1], args[2]) == 1)
  return 1;
else
  return 0;
endif
