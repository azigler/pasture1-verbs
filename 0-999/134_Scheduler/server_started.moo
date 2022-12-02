#134:server_started   this none this xd

caller != #0 && raise(E_PERM);
$code_utils:task_valid(this.cron_task) && resume(this.cron_task);
$code_utils:task_valid(this.timer_task) && resume(this.timer_task);
"Last modified Mon Sep 11 02:36:33 2017 CDT by Jason Perino (#91@ThetaCore).";
