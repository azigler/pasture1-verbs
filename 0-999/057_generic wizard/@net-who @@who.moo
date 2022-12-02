#57:"@net-who @@who"   any any any rd

"@net-who prints all connected users and hosts.";
"@net-who player player player prints specified users and current or most recent connected host.";
"@net-who from hoststring prints all players who have connected from that host or host substring.  Substring can include *'s, e.g. @net-who from *.foo.edu.";
set_task_perms(player);
su = $string_utils;
if (prepstr == "from" && dobjstr)
  player:notify(tostr("Usage:  ", verb, " from <host string>"));
elseif (prepstr != "from" || dobjstr || !iobjstr)
  "Not parsing 'from' here...  Instead printing connected/recent users.";
  if (!(pstrs = args))
    unsorted = connected_players();
  else
    unsorted = listdelete($command_utils:player_match_result(su:match_player(pstrs), pstrs), 1);
  endif
  if (!unsorted)
    return;
  endif
  $wiz_utils:show_netwho_listing(player, unsorted);
else
  $wiz_utils:show_netwho_from_listing(player, iobjstr);
endif
