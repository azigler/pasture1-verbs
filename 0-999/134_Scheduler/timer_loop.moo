#134:timer_loop   this none this xd

":timer_loop(): The core of the timer task scheduler. Checks for timer tasks that need to be run. Suspends until it is time to run another task.";
caller != this && raise(E_PERM);
if (!$code_utils:task_valid(this.timer_task) && this.timer_tasks)
  fork task (0)
    while (this.timer_tasks)
      suspend(this:check_timer_tasks());
    endwhile
  endfork
  this.timer_task = task;
  return task;
endif
"Last modified Thu Sep 14 08:19:04 2017 CDT by Jason Perino (#91@ThetaCore).";
