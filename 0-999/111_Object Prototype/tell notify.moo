#111:"tell notify"   this none this rxd

"Notify a connection of something.";
set_task_perms(caller_perms());
if (this < #0)
  return notify(this, @args);
else
  return this:(verb)(@args);
endif
