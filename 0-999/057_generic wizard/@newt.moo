#57:@newt   any any any rd

"@newt <player> [commentary]";
"turns a player into a newt.  It can get better...";
"adds player to $login.newted, they will not be allowed to log in.";
"Sends mail to $newt_log giving .all_connect_places and commentary.";
whostr = args[1];
comment = $string_utils:first_word(argstr)[2];
if (!player.wizard)
  player:notify("Yeah, right.");
elseif ($command_utils:player_match_failed(who = $string_utils:match_player(whostr), whostr))
  return;
elseif (whostr != who.name && !(whostr in who.aliases) && whostr != tostr(who))
  player:notify(tostr("Must be a full name or an object number:  ", who.name, "(", who, ")"));
  return;
elseif (who == player)
  player:notify("If you want to newt yourself, you have to do it by hand.");
  return;
elseif (who in $login.newted)
  player:notify(tostr(who.name, " appears to already be a newt."));
  return;
else
  $wiz_utils:newt_player(who, comment);
endif
