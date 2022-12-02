#97:init_for_core   this none this rxd

if (caller_perms().wizard)
  this.guests = {};
  pass(@args);
endif
