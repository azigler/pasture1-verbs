#31:my_huh   this none this rxd

if (caller_perms() != this)
  return E_PERM;
else
  return pass(@args);
endif
