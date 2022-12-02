#134:kill_timer   this none this rxd

":kill_timer(id): Kill (remove) a scheduled timer task.";
!caller_perms().wizard && raise(E_PERM);
{id} = args;
lu = $list_utils;
!(t = id in lu:slice(this.timer_tasks)) && raise(E_INVARG);
this.timer_tasks = listdelete(this.timer_tasks, t);
$code_utils:task_valid(this.timer_task) && resume(this.timer_task);
"Last modified Sat Sep  9 20:12:38 2017 CDT by Jason Perino (#91@ThetaCore).";
