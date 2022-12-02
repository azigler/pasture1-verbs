#95:parse_invoke   this none this rxd

if (caller != this)
  raise(E_PERM);
elseif (!(string = args[1]))
  player:tell_lines({"Usage:  " + args[2] + " <object>.<property>", "        " + args[2] + "          (continues editing an unsaved property)"});
elseif (!(objprop = this:property_match_result(string)))
elseif (ERR == typeof(value = this:property(@objprop)))
  player:tell("Couldn't get property value:  ", value);
elseif (typeof(value) != LIST)
  player:tell("Sorry... expecting a list-valued property.");
  if (typeof(value) == STR)
    player:tell("Use @notedit to edit string-valued properties");
  else
    player:tell("Anyway, you don't need an editor to edit `", value, "'.");
  endif
else
  return {@objprop, this:explode_list(0, value)};
endif
return 0;
