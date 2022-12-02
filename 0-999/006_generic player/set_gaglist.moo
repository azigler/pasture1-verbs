#6:set_gaglist   this none this rxd

":set_gaglist(@newlist) => this.gaglist = newlist";
if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return E_PERM;
else
  return this.gaglist = args;
endif
