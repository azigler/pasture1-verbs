#17:expire_old_messages   none none none rxd

"Stop breaking the expire task completely with out of seconds/ticks.";
if (this:ok_write(caller, caller_perms()))
  fork (0)
    pass(@args);
  endfork
else
  return E_PERM;
endif
