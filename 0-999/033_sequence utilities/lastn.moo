#33:lastn   this none this rxd

":lastn(seq,n) => last n elements of seq as a sequence.";
n = args[2];
if ((l = length(seq = args[1])) % 2)
  return {$minint - n};
else
  s = l;
  while (s)
    n = seq[s] - n;
    if (n >= seq[s - 1])
      return {n, @seq[s..l]};
    endif
    n = seq[s - 1] - n;
    s = s - 2;
  endwhile
  return seq;
endif
