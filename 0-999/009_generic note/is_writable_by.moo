#9:is_writable_by   this none this rxd

who = args[1];
wr = this.writers;
if ($perm_utils:controls(who, this))
  return 1;
elseif (typeof(wr) == LIST)
  return who in wr;
else
  return wr;
endif
