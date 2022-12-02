#4:@recycle   any none none rd

set_task_perms(player);
dobj = player:my_match_object(dobjstr);
if (dobj == $nothing)
  player:notify(tostr("Usage:  ", verb, " <object>"));
elseif ($command_utils:object_match_failed(dobj, dobjstr))
  "...bogus object...";
elseif (player == dobj)
  player:notify($wiz_utils.suicide_string);
elseif (!$perm_utils:controls(player, dobj))
  player:notify(tostr(E_PERM));
else
  name = dobj.name;
  if ($command_utils:yes_or_no("Would you like to recycle " + $string_utils:nn(dobj) + "?"))
    result = player:_recycle(dobj);
  else
    return player:tell("Aborting recycle.");
  endif
  if (typeof(result) == ERR)
    player:notify(tostr(result));
  else
    player:notify(tostr(name, " (", dobj, ") recycled."));
  endif
endif
