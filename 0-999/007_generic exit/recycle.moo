#7:recycle   this none this rxd

if (caller == this || $perm_utils:controls(caller_perms(), this))
  try
    this.source:remove_exit(this);
    this.dest:remove_entrance(this);
  except id (ANY)
  endtry
  return pass(@args);
else
  return E_PERM;
endif
