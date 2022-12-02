#55:reverse_suspended   this none this rxd

"reverse(list) => reversed list.  Does suspend(0) as necessary.";
set_task_perms(caller_perms());
"^^^For suspend task.";
return this:_reverse_suspended(@args[1]);
