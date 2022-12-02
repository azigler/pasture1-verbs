#59:task_valid   this none this rxd

"task_valid(INT id)";
"Return true iff there is currently a valid task with the given id.";
set_task_perms($no_one);
{id} = args;
t = $list_utils:slice(queued_tasks(), 1);
return id == task_id() || id in t || E_PERM == `kill_task(id) ! ANY';
