#6:initialize   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  this.help = 0;
  return pass(@args);
else
  return E_PERM;
endif
