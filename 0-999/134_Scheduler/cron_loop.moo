#134:cron_loop   this none this xd

":cron_loop(): The core of the Cron scheduler. Once a minute, checks for Cron tasks that need to be run.";
caller != this && raise(E_PERM);
if (!$code_utils:task_valid(this.cron_task) && (this.special_cron_tasks || this.cron_tasks))
  time = 60 - toint(ctime(time())[18..19]);
  fork task (time)
    while (this.special_cron_tasks || this.cron_tasks)
      this:check_cron_tasks();
      suspend(60 - toint(ctime()[18..19]));
    endwhile
  endfork
  this.cron_task = task;
  return task;
endif
"Last modified Thu Sep 14 08:18:00 2017 CDT by Jason Perino (#91@ThetaCore).";
