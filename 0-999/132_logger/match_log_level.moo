#132:match_log_level   this none this xd

":match_log_level(level): Find all matching log levels.";
{level} = args;
matches = {};
if (!level)
  return matches;
endif
for l in (this.log_levels)
  if (level == l || index(l, level) == 1)
    matches = {@matches, l};
  endif
endfor
return matches;
"Last modified Mon Mar 12 04:25:13 2018 CDT by Jason Perino (#91@ThetaCore).";
