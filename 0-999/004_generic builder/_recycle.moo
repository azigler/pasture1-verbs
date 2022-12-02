#4:_recycle   this none this rxd

set_task_perms(caller_perms());
if (this:build_option("bi_create"))
  return recycle(@args);
else
  return $recycler:(verb)(@args);
endif
