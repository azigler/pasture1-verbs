#30:initialize   this none this rxd

pass(@args);
if ($perm_utils:controls(caller_perms(), this))
  this.r = 1;
  this.f = 0;
endif
