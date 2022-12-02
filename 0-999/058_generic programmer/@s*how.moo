#58:@s*how   any any any rd

set_task_perms(player);
if (dobjstr == "")
  player:notify(tostr("Usage:  ", verb, " <object-or-property-or-verb>"));
  return;
endif
if (index(dobjstr, ".") && (spec = $code_utils:parse_propref(dobjstr)))
  if (valid(object = player:my_match_object(spec[1])))
    return $code_utils:show_property(object, spec[2]);
  endif
elseif (index(dobjstr, ":") && (spec = $code_utils:parse_verbref(dobjstr)))
  if (valid(object = player:my_match_object(spec[1])) && player.programmer)
    return $code_utils:show_verbdef(object, spec[2]);
  else
    player:tell("You must be a programmer to show verbs.");
    return;
  endif
elseif (dobjstr[1] == "$" && (pname = dobjstr[2..$]) in properties(#0) && typeof(#0.(pname)) == OBJ)
  if (valid(object = #0.(pname)))
    return $code_utils:show_object(object);
  endif
elseif (dobjstr[1] == "$" && (spec = $code_utils:parse_propref(dobjstr)))
  return $code_utils:show_property(#0, spec[2]);
else
  if (valid(object = player:my_match_object(dobjstr)))
    return $code_utils:show_object(object);
  endif
endif
$command_utils:object_match_failed(object, dobjstr);
