#26:is_prime   this none this rxd

"is_prime(INT number) returns 1 if the number is prime or 0 if it isn't.";
"of course, only positive numbers are candidates for primality.";
if (typeof(number = args[1]) != INT)
  return E_TYPE;
endif
if (number == 2)
  return 1;
elseif (number < 2 || number % 2 == 0)
  return 0;
else
  max = toint(ceil(sqrt(tofloat(number))));
  choice = 3;
  while (choice <= max)
    if (seconds_left() < 2 || ticks_left() < 25)
      suspend(0);
    endif
    if (number % choice == 0)
      return 0;
    endif
    choice = choice + 2;
  endwhile
endif
return 1;
