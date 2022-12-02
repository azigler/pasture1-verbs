#87:check_name   this none this rxd

pwd = args[1];
if (valid($player_db:find_exact(pwd)))
  return "Passwords may not be close to a player's name/alias pair.";
elseif (valid($player_db:find($string_utils:reverse(pwd))))
  return "Passwords ought not be the reverse of a player's name/alias.";
endif
