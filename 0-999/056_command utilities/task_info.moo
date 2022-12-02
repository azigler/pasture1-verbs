#56:task_info   this none this rxd

"task_info(task id)";
"Return info (the same info supplied by queued_tasks()) about a given task id, or E_INVARG if there's no such task queued.";
"WIZARDLY";
set_task_perms(caller_perms());
tasks = queued_tasks();
task_id = args[1];
for task in (tasks)
  if (task[1] == task_id)
    return task;
  endif
endfor
return E_INVARG;
