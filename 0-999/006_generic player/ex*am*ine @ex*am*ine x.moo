#6:"ex*am*ine @ex*am*ine x"   any none none rd

set_task_perms(player);
if (!dobjstr)
  player:notify(tostr("Usage:  ", verb, " <object>"));
  return E_INVARG;
endif
"what = player.location:match_object(dobjstr);";
what = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(what, dobjstr))
  return;
endif
what:do_examine(player);
"Last modified Sat Dec  3 14:56:24 2022 UTC by caranov (#133).";
