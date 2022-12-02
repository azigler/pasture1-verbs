#65:parse_news   this none this rxd

if (typeof(args[2]) == INT)
  return tostr(strsub(verb, "parse_", ""), " is not a boolean option.");
else
  return {args[1], typeof(args[2]) == STR ? args[2] | $string_utils:from_list(args[2], " ")};
endif
