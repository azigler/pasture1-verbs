#8:set_opened   this none this rxd

if (!$perm_utils:controls(caller.owner, this))
  return E_PERM;
else
  this.opened = opened = !!args[1];
  this.dark = this.opaque > opened;
  return opened;
endif
