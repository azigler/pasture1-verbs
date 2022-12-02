#10:who(vanilla)   this none this rxd

if (caller != #0)
  return E_PERM;
elseif (!args)
  $code_utils:show_who_listing(connected_players()) || this:notify("No one logged in.");
else
  plyrs = listdelete($command_utils:player_match_result($string_utils:match_player(args), args), 1);
  $code_utils:show_who_listing(plyrs);
endif
return 0;
