#33:complement   this none this rxd

":complement(seq[,lower[,upper]]) => the sequence containing all integers *not* in seq.";
"If lower/upper are given, the resulting sequence is restricted to the specified range.";
"Bad things happen if seq is not a subset of [lower..upper]";
{seq, ?lower = $minint, ?upper = $nothing} = args;
if (upper != $nothing)
  if (seq[$] >= (upper = upper + 1))
    seq[$..$] = {};
  else
    seq[$ + 1..$] = {upper};
  endif
endif
if (seq && seq[1] <= lower)
  return listdelete(seq, 1);
else
  return {lower, @seq};
endif
