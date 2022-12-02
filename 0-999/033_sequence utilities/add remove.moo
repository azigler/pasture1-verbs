#33:"add remove"   this none this rxd

"   add(seq,start[,end]) => seq with range added.";
"remove(seq,start[,end]) => seq with range removed.";
"  both assume start<=end.";
remove = verb == "remove";
seq = args[1];
start = args[2];
s = start == $minint ? 1 | $list_utils:find_insert(seq, start - 1);
if (length(args) < 3)
  return {@seq[1..s - 1], @(s + remove) % 2 ? {start} | {}};
else
  e = $list_utils:find_insert(seq, after = args[3] + 1);
  return {@seq[1..s - 1], @(s + remove) % 2 ? {start} | {}, @(e + remove) % 2 ? {after} | {}, @seq[e..$]};
endif
