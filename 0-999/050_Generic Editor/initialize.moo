#50:initialize   this none this rxd

if ($perm_utils:controls(caller_perms(), this))
  pass(@args);
  this:kill_all_sessions();
endif
