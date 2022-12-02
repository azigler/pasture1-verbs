#58:@ref*erence   any any any rd

if (player != this)
  return E_PERM;
endif
set_task_perms(player);
OBJ = player:my_match_object(argstr);
return player:tell($string_utils:nn(OBJ), " => ", $code_utils:corify_object(OBJ));
