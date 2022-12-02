#37:_only   this none this rxd

":_only(prefix,data) => if all strings in this node have the same datum, return it, otherwise, return $ambiguous_match.";
if (caller != this)
  raise(E_PERM);
endif
{prefix, data} = args;
info = this.(" " + prefix);
if (data == 3)
  "... life is much simpler if there's no separate datum.";
  "... if there's more than one string here, we barf.";
  if (info[2] || length(info[3]) > 1)
    return $ambiguous_match;
  elseif (info[3])
    return info[3][1];
  else
    "..this can only happen with the root node of an empty db.";
    return $failed_match;
  endif
elseif (info[2])
  what = this:_only(tostr(prefix, info[1], info[2][1]), data);
  if (what == $ambiguous_match)
    return what;
  endif
elseif (info[data])
  what = info[data][1];
  info[data] = listdelete(info[data], 1);
else
  "..this can only happen with the root node of an empty db.";
  return $failed_match;
endif
for x in (info[data])
  if (what != x)
    return $ambiguous_match;
  endif
endfor
for i in [2..length(info[2])]
  if (what != this:_only(tostr(prefix, info[1], info[2][i]), data))
    return $ambiguous_match;
  endif
endfor
return what;
