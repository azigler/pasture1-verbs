#3:"exits entrances"   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  return this.(verb);
else
  return E_PERM;
endif
