#100:"@who who"   any any any rx

"Redirects calls to @who to $ansi_utils:show_who_listing.";
if (caller != player)
  return E_PERM;
elseif (!(valid(au = $ansi_utils) && au.active))
  return pass(@args);
endif
argstr = prepstr = dobjstr = iobjstr = "";
plyrs = args ? listdelete($command_utils:player_match_result($string_utils:match_player(args), args), 1) | connected_players();
au:show_who_listing(plyrs);
