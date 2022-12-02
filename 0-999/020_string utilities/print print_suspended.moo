#20:"print print_suspended"   this none this rxd

"$string_utils:print(value)";
"Print the given value into a string. == from_value(value,1,-1)";
return toliteral(args[1]);
value = args[1];
if (typeof(value) == LIST)
  if (value)
    result = "{" + this:print(value[1]);
    for val in (listdelete(value, 1))
      result = tostr(result, ", ", this:print(val));
    endfor
    return result + "}";
  else
    return "{}";
  endif
elseif (typeof(value) == STR)
  return tostr("\"", strsub(strsub(value, "\\", "\\\\"), "\"", "\\\""), "\"");
elseif (typeof(value) == ERR)
  return $code_utils:error_name(value);
else
  return tostr(value);
endif
