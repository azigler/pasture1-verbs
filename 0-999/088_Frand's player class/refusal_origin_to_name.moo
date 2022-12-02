#88:refusal_origin_to_name   this none this rxd

"'refusal_origin_to_name (<origin>)' -> string - Convert a refusal origin to a name.";
origin = args[1];
if (origin in {"all guests", "everybody"})
  return origin;
elseif (typeof(origin) == STR && origin == "Permission denied")
  return "an errorful origin";
elseif (typeof(origin) != OBJ)
  return "a certain guest";
elseif (origin == #-1)
  return "Everybody";
else
  return $string_utils:name_and_number(origin);
endif
