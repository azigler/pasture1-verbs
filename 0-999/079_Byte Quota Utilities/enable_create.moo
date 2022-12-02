#79:enable_create   this none this rxd

if (caller != this && !caller_perms().wizard)
  return E_PERM;
else
  args[1].ownership_quota = 1;
endif
