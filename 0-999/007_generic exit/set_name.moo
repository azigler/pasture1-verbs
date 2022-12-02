#7:set_name   this none this rxd

if ($perm_utils:controls(cp = caller_perms(), this) || (valid(this.source) && this.source.owner == cp))
  return typeof(e = `this.name = args[1] ! ANY') != ERR || e;
else
  return E_PERM;
endif
