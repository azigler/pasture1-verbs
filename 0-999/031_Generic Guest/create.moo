#31:create   any any any rd

if ($login:player_creation_enabled(player))
  player:tell("First @quit, then connect to the MOO again and, rather than doing `connect guest' do `create <name> <password>'");
else
  player:tell($login:registration_string());
endif
