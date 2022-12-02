#19:find_topics   this none this rxd

if (!args)
  l = {};
  for p in (properties(#0))
    if (p[max(1, $ - 5)..$] == "_utils" && `#0.(p):help_msg() ! ANY')
      l = {@l, "$" + p};
    endif
  endfor
  return {@pass(@args), @l};
elseif (ts = pass(@args))
  return ts;
elseif ((what = args[1])[1] != "$")
  return {};
elseif (ts = pass("$generic_" + what[2..$]))
  return ts;
elseif ((r = rindex(w = strsub(what[2..$], "-", "_"), "_utils")) && (r == length(w) - 5 && (`valid(#0.(w)) ! ANY' && `#0.(w):help_msg() ! ANY')))
  return {what};
else
  return {};
endif
