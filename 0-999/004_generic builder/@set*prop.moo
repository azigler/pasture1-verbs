#4:@set*prop   any (at/to) any rd

"Syntax:  @set <object>.<prop-name> to <value>";
"";
"Changes the value of the specified object's property to the given value.";
"You must have permission to modify the property, either because you own the property or if it is writable.";
set_task_perms(player);
if (this != player)
  return player:tell(E_PERM);
endif
l = $code_utils:parse_propref(dobjstr);
if (l)
  dobj = player:my_match_object(l[1], player.location);
  if ($command_utils:object_match_failed(dobj, l[1]))
    return;
  endif
  prop = l[2];
  to_i = "to" in args;
  at_i = "at" in args;
  i = to_i && at_i ? min(to_i, at_i) | to_i || at_i;
  iobjstr = argstr[$string_utils:word_start(argstr)[i][2] + 1..$];
  iobjstr = $string_utils:trim(iobjstr);
  if (!iobjstr)
    try
      val = dobj.(prop) = "";
    except e (ANY)
      player:tell("Unable to set ", dobj, ".", prop, ": ", e[2]);
      return;
    endtry
    iobjstr = "\"\"";
    "elseif (iobjstr[1] == \"\\\"\")";
    "val = dobj.(prop) = iobjstr;";
    "iobjstr = \"\\\"\" + iobjstr + \"\\\"\";";
  else
    val = $string_utils:to_value(iobjstr);
    if (!val[1])
      player:tell("Could not parse: ", iobjstr);
      return;
    elseif (!$object_utils:has_property(dobj, prop))
      player:tell("That object does not define that property.");
      return;
    endif
    try
      val = dobj.(prop) = val[2];
    except e (ANY)
      player:tell("Unable to set ", dobj, ".", prop, ": ", e[2]);
      return;
    endtry
  endif
  player:tell("Property ", dobj, ".", prop, " set to ", $string_utils:print(val), ".");
else
  player:tell("Property ", dobjstr, " not found.");
endif
