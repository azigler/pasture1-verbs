#134:schedule_cron   this none this rxd

":schedule_cron(minute, hour, day, month, weekday, object, verb[, args[, owner]]): Schedule a Cron task.";
!caller_perms().wizard && raise(E_PERM);
{minute, hour, day, month, weekday, object, vrb, ?args = {}, ?owner = caller_perms()} = args;
lu = $list_utils;
ou = $object_utils;
!this:validate_range(minute, 0, 59) || !this:validate_range(hour, 0, 23) || !this:validate_range(day, 1, 31) || !this:validate_range(month, 1, 12) || !this:validate_range(weekday, 0, 6) || !`is_player(owner) ! ANY => 0' && raise(E_INVARG);
!`$recycler:valid(object) ! ANY => 0' || typeof(vrb) != STR || !ou:has_callable_verb(object, vrb) && raise(E_VERBNF);
while ((id = random()) in lu:slice(this.cron_tasks))
endwhile
this.cron_tasks = setadd(this.cron_tasks, {id, 0, minute, hour, day, month, weekday, owner, object, vrb, args});
!$code_utils:task_valid(this.cron_task) && this:cron_loop();
return id;
"Last modified Sat Sep  9 20:11:48 2017 CDT by Jason Perino (#91@ThetaCore).";
