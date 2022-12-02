#20:index_all   this none this rxd

"index_all(string,target) -- returns list of positions of target in string.";
"Usage: $string_utils:index_all(<string,pattern>)";
"       $string_utils:index_all(\"aaabacadae\",\"a\")";
{line, pattern} = args;
if (typeof(line) != STR || typeof(pattern) != STR)
  return E_TYPE;
else
  where = {};
  place = -1;
  next = 0;
  while ((place = index(line[next + 1..$], pattern)) != 0)
    where = {@where, place + next};
    next = place + next + length(pattern) - 1;
  endwhile
  return where;
endif
