#20:from_value_suspended   this none this rxd

"$string_utils:from_value(value [, quote_strings = 0 [, list_depth = 1]])";
"Print the given value into a string.";
"This verb suspends as necessary for large values.";
set_task_perms(caller_perms());
{value, ?quote_strings = 0, ?list_depth = 1} = args;
if (typeof(value) == LIST)
  if (value)
    if (list_depth)
      result = "{" + this:from_value(value[1], quote_strings, list_depth - 1);
      for v in (listdelete(value, 1))
        $command_utils:suspend_if_needed(0);
        result = tostr(result, ", ", this:from_value(v, quote_strings, list_depth - 1));
      endfor
      return result + "}";
    else
      return "{...}";
    endif
  else
    return "{}";
  endif
elseif (quote_strings)
  if (typeof(value) == STR)
    result = "\"";
    while (q = index(value, "\"") || index(value, "\\"))
      $command_utils:suspend_if_needed(0);
      if (value[q] == "\"")
        q = min(q, index(value + "\\", "\\"));
      endif
      result = result + value[1..q - 1] + "\\" + value[q];
      value = value[q + 1..$];
    endwhile
    return result + value + "\"";
  elseif (typeof(value) == ERR)
    return $code_utils:error_name(value);
  else
    return tostr(value);
  endif
else
  return tostr(value);
endif
