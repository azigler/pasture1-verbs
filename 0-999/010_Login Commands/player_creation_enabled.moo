#10:player_creation_enabled   this none this rxd

"Accepts a player object.  If player creation is enabled for that player object, then return true.  Otherwise, return false.";
"Default implementation checks the player's connecting host via $login:blacklisted to decide.";
if (caller_perms().wizard)
  return this.create_enabled && !this:blacklisted($string_utils:connection_hostname(args[1]));
else
  return E_PERM;
endif
