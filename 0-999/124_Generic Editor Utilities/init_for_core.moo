#124:init_for_core   this none this rxd

if (caller_perms().wizard)
  this.last_edits = {};
  this.sessions = {};
  pass(@args);
endif
