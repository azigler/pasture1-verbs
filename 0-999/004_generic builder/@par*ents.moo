#4:@par*ents   any none none rd

"'@parents <thing>' - List <thing> and its ancestors, all the way back to the Root Class (#1).";
if (player != this)
  return player:notify("Permission denied: not a builder.");
elseif (!dobjstr)
  player:notify(tostr("Usage:  ", verb, " <object>"));
  return;
endif
set_task_perms(player);
o = player:my_match_object(dobjstr);
if (!$command_utils:object_match_failed(o, dobjstr))
  player:notify($string_utils:names_of({o, @$object_utils:ancestors(o)}));
endif
