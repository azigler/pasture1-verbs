#6:@who   any any any rxd

if (caller != player)
  return E_PERM;
endif
plyrs = args ? listdelete($command_utils:player_match_result($string_utils:match_player(args), args), 1) | connected_players();
if (!plyrs)
  return;
elseif (length(plyrs) > 100)
  player:tell("You have requested a listing of ", length(plyrs), " players.  Please either specify individual players you are interested in, to reduce the number of players in any single request, or else use the `@users' command instead.  The lag thanks you.");
  return;
endif
$code_utils:show_who_listing(plyrs);
