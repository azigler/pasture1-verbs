#38:set_*   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  return pass(@args);
endif
