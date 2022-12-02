#20:_abbreviated_value   this none this rxd

"Copied from Mickey (#52413):_abbreviated_value Fri Sep  9 08:52:44 1994 PDT";
"Internal to :abbreviated_value.  Do not call this directly.";
{value, max_reslen, max_lstlev, max_lstlen, max_strlen, max_toklen} = args;
if ((type = typeof(value)) == LIST)
  if (!value)
    return "{}";
  elseif (max_lstlev == 0)
    return "{...}";
  else
    n = length(value);
    result = "{";
    r = max_reslen - 2;
    i = 1;
    eltstr = "";
    while (i <= n && i <= max_lstlen && r > (x = i == 1 ? 0 | 2))
      eltlen = length(eltstr = this:(verb)(value[i], r, max_lstlev - 1, max_lstlen, max_strlen, max_toklen));
      lastpos = 1;
      if (r >= eltlen + x)
        comma = i == 1 ? "" | ", ";
        result = tostr(result, comma);
        if (r > 4)
          lastpos = length(result);
        endif
        result = tostr(result, eltstr);
        r = r - eltlen - x;
      elseif (i == 1)
        return "{...}";
      elseif (r > 4)
        return tostr(result, ", ...}");
      else
        return tostr(result[1..lastpos], "...}");
      endif
      i = i + 1;
    endwhile
    if (i <= n)
      if (i == 1)
        return "{...}";
      elseif (r > 4)
        return tostr(result, ", ...}");
      else
        return tostr(result[1..lastpos], "...}");
      endif
    else
      return tostr(result, "}");
    endif
  endif
elseif (type == STR)
  result = "\"";
  while ((q = index(value, "\"")) ? q = min(q, index(value, "\\")) | (q = index(value, "\\")))
    result = result + value[1..q - 1] + "\\" + value[q];
    value = value[q + 1..$];
  endwhile
  result = result + value;
  if (length(result) + 1 > (z = max(min(max_reslen, max(max_strlen, max_strlen + 2)), 6)))
    z = z - 5;
    k = 0;
    while (k < z && result[z - k] == "\\")
      k = k + 1;
    endwhile
    return tostr(result[1..z - k % 2], "\"+...");
  else
    return tostr(result, "\"");
  endif
else
  v = type == ERR ? $code_utils:error_name(value) | tostr(value);
  len = max(4, min(max_reslen, max_toklen));
  return length(v) > len ? v[1..len - 3] + "..." | v;
endif
"Originally written by Mickey.";
