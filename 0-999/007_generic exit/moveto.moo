#7:moveto   this none this rxd

if (caller in {this, this.owner} || $perm_utils:controls(caller_perms(), this))
  return pass(@args);
else
  return E_PERM;
endif
