#55:sort_suspended   this none this rxd

":sort_suspended(interval,list[,keys]) => sorts keys (assumed to be all numbers or strings) and returns list with the corresponding permutation applied to it.  keys defaults to the list itself.";
"Note: For compatibility with LambdaCore, the interval argument hasn't been removed. In ToastStunt, however, it's not used. Instead, the task will suspend until the sort thread has finished.";
set_task_perms(caller_perms());
return sort(@args[2..$]);
