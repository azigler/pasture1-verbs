#99:cutoff*_suspended   this none this rx

":cutoff[_suspended] (STR string, NUM start, NUM end) => STR";
"Acts like: string[start..end] but ignores ANSI codes.";
args = {@args, 0}[1..4];
if (typeof(info = this:cutoff_locs(@args, verb == "cutoff_suspended")) == LIST)
  return args[1][info[1]..info[2]];
else
  return info;
endif
