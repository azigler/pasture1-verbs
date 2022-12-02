#15:eject   this none this rxd

if ($perm_utils:controls(caller_perms(), this))
  if ((what = args[1]).wizard && what.location == this)
    move(what, what.home);
  else
    return pass(@args);
  endif
endif
