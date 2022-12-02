#134:"schedule_timer schedule_timer_every"   this none this rxd

":schedule_timer(interval, object, \"verb\"[, args[, owner]]): Schedule a timer task to be executed after a specific number of seconds have elapsed.";
"The schedule_timer_every variant will schedule the task to be run indefinitely, every interval seconds.";
!caller_perms().wizard && raise(E_PERM);
{interval, object, vrb, ?args = {}, ?owner = caller_perms()} = args;
lu = $list_utils;
ou = $object_utils;
typeof(interval) != INT || interval <= 0 || !`$recycler:valid(object) ! ANY => 0' || typeof(vrb) != STR || !ou:has_callable_verb(object, vrb) || typeof(args) != LIST || !`$recycler:valid(owner) ! ANY => 0' && raise(E_INVARG);
while ((id = random()) in lu:slice(this.timer_tasks))
endwhile
this.timer_tasks = setadd(this.timer_tasks, {id, verb[$ - 4..$] == "every" ? interval | 0, time(), time() + interval, owner, object, vrb, args});
$code_utils:task_valid(this.timer_task) ? resume(this.timer_task) | this:timer_loop();
return id;
"Last modified Sat Sep  9 20:11:04 2017 CDT by Jason Perino (#91@ThetaCore).";
