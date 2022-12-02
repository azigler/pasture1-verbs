#77:parse_create_flags   this none this rxd

raw = args[2];
if (raw == 1)
  "...+create_flags => create_flags=r";
  return {args[1], "r"};
elseif (typeof(raw) == STR)
  return args[1..2];
elseif (typeof(raw) != LIST)
  return "???";
elseif (length(raw) > 1)
  return tostr("I don't understand \"", $string_utils:from_list(listdelete(raw, 1), " "), "\"");
else
  return {args[1], raw[1]};
endif
