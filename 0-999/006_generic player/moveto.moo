#6:moveto   this none this rxd

if (args[1] == #-1)
  return E_INVARG;
  this:notify("You are now in #-1, The Void.  Type `home' to get back.");
endif
set_task_perms(caller_perms());
pass(@args);
"Last modified Sat Dec  3 19:43:10 2022 UTC by caranov (#133).";
