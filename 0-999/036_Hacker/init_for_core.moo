#36:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.mail_forward = {$owner};
endif
