#61:add_current_news   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
else
  return this:set_current_news($seq_utils:union(this.current_news, args[1]));
endif
