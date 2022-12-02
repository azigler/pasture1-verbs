#76:parse_verb_args   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) == STR)
  raw = $string_utils:explode(raw, " ");
elseif (typeof(raw) == INT)
  return raw ? {oname, {"this", "none", "this"}} | {oname, 0};
endif
value = $code_utils:parse_argspec(@raw);
if (typeof(value) != LIST)
  return tostr(value);
elseif (value[2])
  return tostr("I don't understand \"", $string_utils:from_list(value[2], " "), "\"");
else
  value = {@value[1], "none", "none", "none"}[1..3];
  return {oname, value == {"none", "none", "none"} ? 0 | value};
endif
