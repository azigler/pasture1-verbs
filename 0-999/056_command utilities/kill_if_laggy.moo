#56:kill_if_laggy   this none this rxd

"Kills this task if the current lag is greater than args[1].  Args[2..n] will be passed to player:tell.";
cutoff = args[1];
if ($login:current_lag() > cutoff)
  player:tell(@listdelete(args, 1));
  kill_task(task_id());
endif
