#88:@rmword   any any any rd

set_task_perms(player);
if (argstr in player.dict)
  player.dict = setremove(player.dict, argstr);
  player:notify(tostr("`", argstr, "' removed from personal dictionary."));
else
  player:notify(tostr("`", argstr, "' not found in personal dictionary."));
endif
