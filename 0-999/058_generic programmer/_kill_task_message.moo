#58:_kill_task_message   this none this rxd

set_task_perms(caller_perms());
task = args[1];
player:notify(tostr("Killed: ", $string_utils:right(tostr("task ", task[1]), 17), ", verb ", task[6], ":", task[7], ", line ", task[8], task[9] != task[6] ? ", this==" + tostr(task[9]) | ""));
