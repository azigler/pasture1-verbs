#25:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this:clearall();
  this.domain = "localdomain";
  this:prune_reset();
endif
