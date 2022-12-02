#134:check_timer_tasks   this none this xd

":check_timer_tasks(): Check whether scheduled timer tasks need to be executed.";
"";
"This should only be called by the scheduler itself...";
caller != this && raise(E_PERM);
suspend_time = 86400;
t = 1;
while (t <= length(this.timer_tasks))
  {task_id, task_interval, task_schedule_time, task_time, task_owner, object, verb, task_args} = this.timer_tasks[t];
  if (task_time <= time())
    fork (0)
      try
        set_task_perms(task_owner);
        object:(verb)(@task_args);
      except e (ANY)
        "I use my traceback handler and logger here, but you may want to do something different.";
        "tb = $tb_handler:format_traceback(e[2], e[4], \"\");";
        "$logger:notice(\"tracebacks\", {(((\"Traceback from \" + $su:nn(this)) + \" while firing timer task ID \") + tostr(task_id)) + \"):\", @tb});";
        raise(e[1]);
      endtry
    endfork
    if (task_interval)
      task_time = this.timer_tasks[t][4] = time() + task_interval - (time() - task_schedule_time) % task_interval;
    else
      task_time = 0;
      this.timer_tasks = listdelete(this.timer_tasks, t);
      continue;
    endif
  endif
  if ((time = task_time - time()) < suspend_time && time > 0)
    suspend_time = task_time - time();
  endif
  t = t + 1;
endwhile
return this.timer_tasks ? suspend_time | 0;
"Last modified Mon Sep 11 01:58:20 2017 CDT by Jason Perino (#91@ThetaCore).";
