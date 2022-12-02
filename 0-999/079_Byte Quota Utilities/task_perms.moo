#79:task_perms   this none this rxd

"Put all your wizards in $byte_quota_utils.wizards.  Then various long-running tasks will cycle among the permissions, spreading out the scheduler-induced personal lag.";
$wiz_utils.old_task_perms_user = setadd($wiz_utils.old_task_perms_user, caller);
return $wiz_utils:random_wizard();
