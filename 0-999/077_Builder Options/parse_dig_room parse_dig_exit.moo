#77:"parse_dig_room parse_dig_exit"   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) == LIST)
  if (length(raw) > 1)
    return tostr("I don't understand \"", $string_utils:from_list(listdelete(raw, 1), " "), "\".");
  endif
  raw = raw[1];
endif
if (typeof(raw) != STR)
  return "You need to give an object id.";
elseif ($command_utils:object_match_failed(value = player:my_match_object(raw), raw))
  return "Option unchanged.";
endif
what = verb == "parse_dig_room" ? "room" | "exit";
generic = #0.(what);
if (value == generic)
  return {oname, 0};
else
  if (!$object_utils:isa(value, generic))
    player:tell("Warning: ", value, " is not a descendant of $", what, ".");
  endif
  return {oname, value};
endif
