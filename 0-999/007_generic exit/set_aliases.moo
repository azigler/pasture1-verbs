#7:set_aliases   this none this rxd

if ($perm_utils:controls(cp = caller_perms(), this) || (valid(this.source) && this.source.owner == cp))
  if (typeof(e = `this.aliases = args[1] ! ANY') == ERR)
    return e;
  else
    return 1;
  endif
else
  return E_PERM;
endif
