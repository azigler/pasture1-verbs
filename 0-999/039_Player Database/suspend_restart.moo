#39:suspend_restart   this none this rxd

"used during :load to do the usual out-of-time check.";
"if someone makes a modification during the suspension (indicated by this.frozen being set to 2), we have to restart the entire load.";
if (caller != this)
  return E_PERM;
elseif ($command_utils:running_out_of_time())
  player:tell("...", args[1]);
  set_task_perms($byte_quota_utils:task_perms());
  suspend(0);
  if (this.frozen != 1)
    player:tell("...argh... restarting $player_db:load...");
    fork (0)
      this:load();
    endfork
    kill_task(task_id());
  endif
endif
