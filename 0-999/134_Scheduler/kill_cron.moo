#134:kill_cron   this none this rxd

":kill_cron(id): Kill (remove) a Cron task.";
!caller_perms().wizard && raise(E_PERM);
{id} = args;
lu = $list_utils;
!(t = id in lu:slice(this.cron_tasks)) && raise(E_INVARG);
this.cron_tasks = listdelete(this.cron_tasks, t);
"Last modified Sat Sep  9 20:09:07 2017 CDT by Jason Perino (#91@ThetaCore).";
