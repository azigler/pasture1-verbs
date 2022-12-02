#6:erase_paranoid_data   this none this rxd

if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
else
  $paranoid_db:erase_data(this);
endif
