#56:suspend_if_needed   this none this rxd

"Usage:  $command_utils:suspend_if_needed(<time>[, @<announcement>])";
"See if we're running out of ticks or seconds, and if so suspend(<time>) and return true.  If more than one arg is given, print the remainder with player:tell.";
if (ticks_left() < 4000 || seconds_left() < 2)
  "Note: above computation should be the same as :running_out_of_time.";
  {?time = 10, @ann} = args;
  if (ann && valid(player))
    player:tell(tostr(@ann));
  endif
  amount = max(time, min($login:current_lag(), 10));
  set_task_perms(caller_perms());
  "this is trying to back off according to lag...";
  suspend(amount);
  return 1;
endif
