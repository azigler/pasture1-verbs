#45:initialize   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  this.mail_forward = {};
  return pass(@args);
endif
