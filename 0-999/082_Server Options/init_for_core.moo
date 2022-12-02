#82:init_for_core   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
this.support_numeric_verbname_strings = 0;
pass(@args);
