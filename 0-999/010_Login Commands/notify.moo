#10:notify   this none this rxd

caller != $ansi_utils && set_task_perms(caller_perms());
notify(player, $ansi_utils:delete(args[1]));
