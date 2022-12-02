#8:set_opaque   this none this rxd

if (!$perm_utils:controls(caller.owner, this))
  return E_PERM;
elseif (typeof(number = args[1]) != INT)
  return E_INVARG;
else
  number = number < 0 ? 0 | (number > 2 ? 2 | number);
  this.dark = number > this.opened;
  return this.opaque = number;
endif
