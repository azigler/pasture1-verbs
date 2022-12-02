#37:find_exact   this none this rxd

{search, ?sofar = 0} = args;
rest = search;
prefix = search[1..sofar];
rest[1..sofar] = "";
info = this.(" " + prefix);
if (i = search in info[3])
  return info[this.data][i];
elseif (length(rest) <= (common = length(info[1])) || rest[1..common] != info[1])
  return $failed_match;
elseif (index(info[2], search[sofar + common + 1]))
  return this:find_exact(search, sofar + common + 1);
else
  return $failed_match;
endif
