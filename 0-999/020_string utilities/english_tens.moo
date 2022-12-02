#20:english_tens   this none this rxd

numb = args[1];
teens = {"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
others = {"twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"};
if (numb < 10)
  return this:english_ones(numb);
elseif (numb < 20)
  return teens[numb - 9];
else
  return others[numb / 10 - 1] + (numb % 10 ? "-" | "") + this:english_ones(numb % 10);
endif
