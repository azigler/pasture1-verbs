#54:do_burn   this none this rxd

if (this != $letter && (caller == this || $perm_utils:controls(caller_perms(), this)))
  fork (0)
    $recycler:_recycle(this);
  endfork
  return 1;
else
  return E_PERM;
endif
