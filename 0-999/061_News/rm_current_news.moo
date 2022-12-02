#61:rm_current_news   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
else
  return this:set_current_news($seq_utils:intersection(this.current_news, $seq_utils:complement(args[1])));
endif
