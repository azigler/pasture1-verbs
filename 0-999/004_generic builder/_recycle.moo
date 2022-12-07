#4:_recycle   this none this rxd

set_task_perms(caller_perms());
if ($object_utils:has_verb(args[1], "pre_recycle"))
  args[1]:pre_recycle();
endif
if (this:build_option("bi_create"))
  return recycle(@args);
else
  return $recycler:(verb)(@args);
endif
