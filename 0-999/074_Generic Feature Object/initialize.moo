#74:initialize   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  pass(@args);
  this.feature_verbs = {};
else
  return E_PERM;
endif
