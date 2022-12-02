#134:check_cron_tasks   this none this xd

":check_cron_tasks(): Checks if Cron-based tasks need to be executed.";
"";
"This should only be called by the scheduler itself...";
"(caller != this) && raise(E_PERM);";
su = $string_utils;
tu = $time_utils;
now = ctime();
minute = toint(now[15..16]);
hour = toint(now[12..13]);
day = toint(now[9..10]);
month = now[5..7] in tu.monthabbrs;
weekday = (now[1..3] in tu.dayabbrs) - 1;
for tasklist in ({"special_cron_tasks", "cron_tasks"})
  for t in [1..length(this.(tasklist))]
    {task_id, task_last_run, task_minute, task_hour, task_day, task_month, task_weekday, task_owner, object, verb, task_args} = this.(tasklist)[t];
    task_owner = task_owner == $nothing ? this.owner | task_owner;
    object = object == $nothing ? this | object;
    if (this:check_range(minute, task_minute) && this:check_range(hour, task_hour) && this:check_range(day, task_day) && this:check_range(month, task_month) && this:check_range(weekday, task_weekday))
      fork (0)
        try
          set_task_perms(task_owner);
          object:(verb)(@task_args);
        except e (ANY)
          "I use my traceback handler and logger here, but you may want to do something different.";
          "tb = $tb_handler:format_traceback(e[2], e[4], \"\");";
          "$logger:notice(\"tracebacks\", {(((\"Traceback from \" + su:tn(this)) + \" while firing Cron task ID \") + tostr(task_id)) + \"):\", @tb});";
          raise(e[1]);
        endtry
      endfork
      this.(tasklist)[t][2] = time();
    endif
  endfor
endfor
"Last modified Mon Sep 11 01:57:50 2017 CDT by Jason Perino (#91@ThetaCore).";
