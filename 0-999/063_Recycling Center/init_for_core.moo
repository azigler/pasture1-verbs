#63:init_for_core   this none this rxd

if (caller_perms().wizard)
  this.orphans = {};
  this.history = {};
  this.lost_souls = {};
  pass(@args);
endif
