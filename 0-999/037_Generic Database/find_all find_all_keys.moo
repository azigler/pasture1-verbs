#37:"find_all find_all_keys"   this none this rxd

":find_all(string [,n=0])";
"assumes n <= length(string)";
{search, ?sofar = 0} = args;
rest = search;
prefix = search[1..sofar];
rest[1..sofar] = "";
info = this.(" " + prefix);
data = verb == "find_all" ? this.data | 3;
if (index(info[1], rest) == 1)
  "...return entire subtree.";
  return this:(data == 3 ? "_every_key" | "_every")(prefix);
elseif (index(rest, info[1]) != 1)
  "...common portion doesn't agree.";
  return {};
elseif (index(info[2], rest[1 + (common = length(info[1]))]))
  "...matching strings are in a subnode.";
  return this:(verb)(search, sofar + common + 1);
else
  "...matching string is in info[3].  length(rest) > common,";
  "...so there will be at most one matching string.";
  for i in [1..length(info[3])]
    if (index(info[3][i], search) == 1)
      return {info[data][i]};
    endif
  endfor
  return {};
endif
