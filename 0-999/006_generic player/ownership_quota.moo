#6:ownership_quota   this none this rxd

if ($perm_utils:controls(caller_perms(), this))
  return this.(verb);
else
  return E_PERM;
endif
