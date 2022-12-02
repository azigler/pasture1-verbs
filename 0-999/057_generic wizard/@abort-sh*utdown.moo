#57:@abort-sh*utdown   any any any rd

if (!player.wizard)
  player:notify("Sorry.");
elseif (!$code_utils:task_valid($wiz_utils.shutdown_task))
  player:notify("No server shutdown in progress.");
  $wiz_utils.shutdown_task = E_NONE;
else
  "... Reset time so that $login:check_for_shutdown shuts up...";
  kill_task($wiz_utils.shutdown_task);
  $wiz_utils.shutdown_task = E_NONE;
  $server["shutdown_time"] = time() - 1;
  for p in (connected_players())
    notify(p, tostr("*** Server shutdown ABORTED by ", player.name, " (", player, ")", argstr && ":  " + argstr, " ***"));
  endfor
endif
