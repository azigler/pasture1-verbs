#33:tolist   this none this rxd

seq = args[1];
if (!seq)
  return {};
else
  if (length(seq) % 2)
    seq = {@seq, $minint};
  endif
  l = {};
  for i in [1..length(seq) / 2]
    for j in [seq[2 * i - 1]..seq[2 * i] - 1]
      l = {@l, j};
    endfor
  endfor
  return l;
endif
