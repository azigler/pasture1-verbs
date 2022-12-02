#24:isnewt   this none this rxd

"Return 1 if args[1] is a newted player.";
if (!caller_perms().wizard)
  return E_PERM;
else
  return args[1] in $login.newted;
endif
