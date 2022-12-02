#10:"w*ho @w*ho"   any none any rxd

masked = $login.who_masks_wizards ? $wiz_utils:connected_wizards() | {};
if (caller != #0 && caller != this)
  return E_PERM;
elseif (!args)
  plyrs = connected_players();
  if (length(plyrs) > 100)
    this:notify(tostr("You have requested a listing of ", length(plyrs), " players.  Please restrict the number of players in any single request to a smaller number.  The lag thanks you."));
    return 0;
  else
    $ansi_utils:show_who_listing($set_utils:difference(plyrs, masked)) || this:notify("No one logged in.");
  endif
else
  plyrs = listdelete($command_utils:player_match_result($string_utils:match_player(args), args), 1);
  if (length(plyrs) > 100)
    this:notify(tostr("You have requested a listing of ", length(plyrs), " players.  Please restrict the number of players in any single request to a smaller number.  The lag thanks you."));
    return 0;
  endif
  $ansi_utils:show_who_listing(plyrs, $set_utils:intersection(plyrs, masked));
endif
return 0;
