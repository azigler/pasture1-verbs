#4:@unlock   any none none rd

set_task_perms(player);
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
try
  dobj.key = 0;
  player:notify(tostr("Unlocked ", dobj.name, "."));
except error (ANY)
  player:notify(error[2]);
endtry
