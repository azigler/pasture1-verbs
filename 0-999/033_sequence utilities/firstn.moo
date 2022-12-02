#33:firstn   this none this rxd

":firstn(seq,n) => first n elements of seq as a sequence.";
if ((n = args[2]) <= 0)
  return {};
endif
l = length(seq = args[1]);
s = 1;
while (s <= l)
  n = n + seq[s];
  if (s >= l || n <= seq[s + 1])
    return {@seq[1..s], n};
  endif
  n = n - seq[s + 1];
  s = s + 2;
endwhile
return seq;
