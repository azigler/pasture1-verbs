#84:init_for_core   this none this rxd

if (!caller_perms().wizard)
  raise(E_PERM);
endif
pass(@args);
this.("@quota") = {"*forward*", "object-quota"};
