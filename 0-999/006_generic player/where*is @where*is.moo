#6:"where*is @where*is"   any any any rxd

if (!args)
  them = connected_players();
else
  who = $command_utils:player_match_result($string_utils:match_player(args), args);
  if (length(who) <= 1)
    if (!who[1])
      player:notify("Where is who?");
    endif
    return;
  elseif (who[1])
    player:notify("");
  endif
  them = listdelete(who, 1);
endif
lmax = rmax = 0;
for p in (them)
  player:notify(tostr($string_utils:left($string_utils:nn(p), 25), " ", $string_utils:nn(p.location)));
endfor
