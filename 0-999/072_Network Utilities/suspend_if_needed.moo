#72:suspend_if_needed   this none this rxd

"$command_utils:suspend_if_needed but chowned to player";
if ($command_utils:running_out_of_time())
  set_task_perms(caller_perms().wizard ? player | caller_perms());
  return $command_utils:suspend_if_needed(@args);
endif
