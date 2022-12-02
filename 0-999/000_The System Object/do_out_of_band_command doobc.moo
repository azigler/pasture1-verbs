#0:"do_out_of_band_command doobc"   this none this rxd

"do_out_of_band_command -- a cheap and very dirty do_out_of_band verb.  Forwards to verb on player with same name if it exists, otherwise forwards to $login.  May only be called by the server in response to an out of band command, otherwise E_PERM is returned.";
if (caller == #-1 && caller_perms() == #-1 && callers() == {})
  if (valid(player) && is_player(player))
    $mcp:(verb)(@args);
    set_task_perms(player);
    $object_utils:has_callable_verb(player, "do_out_of_band_command") && player:do_out_of_band_command(@args);
  else
    $login:do_out_of_band_command(@args);
  endif
else
  return E_PERM;
endif
