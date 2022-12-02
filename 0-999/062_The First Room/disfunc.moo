#62:disfunc   this none this rxd

"Copied from The Coat Closet (#11):disfunc by Haakon (#2) Mon May  8 10:41:04 1995 PDT";
if ((cp = caller_perms()) == (who = args[1]) || $perm_utils:controls(cp, who) || caller == this)
  "need the first check since guests don't control themselves";
  if (who.home == this)
    move(who, $limbo);
    this:announce("You hear a quiet popping sound; ", who.name, " has disconnected.");
  else
    pass(who);
  endif
endif
