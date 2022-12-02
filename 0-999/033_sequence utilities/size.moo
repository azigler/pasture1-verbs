#33:size   this none this rxd

":size(seq) => number of elements in seq";
"  for sequences consisting of more than half of the 4294967298 available integers, this returns a negative number, which can either be interpreted as (cardinality - 4294967298) or -(size of complement sequence)";
n = 0;
for i in (seq = args[1])
  n = i - n;
endfor
return length(seq) % 2 ? $minint - n | n;
