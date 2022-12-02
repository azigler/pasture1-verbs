#58:@rmprop*erty   any any any rd

set_task_perms(player);
if (length(args) != 1 || !(spec = $code_utils:parse_propref(args[1])))
  player:notify(tostr("Usage:  ", verb, " <object>.<property>"));
  return;
endif
object = player:my_match_object(spec[1]);
pname = spec[2];
if ($command_utils:object_match_failed(object, spec[1]))
  return;
endif
try
  result = delete_property(object, pname);
  player:notify("Property removed.");
except (E_PROPNF)
  player:notify("That object does not define that property.");
except res (ANY)
  player:notify(res[2]);
endtry
