#6:"exam*ine @exam*ine x"   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:notify(tostr("Usage:  ", verb, " <object>"));
  return E_INVARG;
endif
what = player.location:match_object(dobjstr);
if ($command_utils:object_match_failed(what, dobjstr))
  return;
endif
what:do_examine(player);
