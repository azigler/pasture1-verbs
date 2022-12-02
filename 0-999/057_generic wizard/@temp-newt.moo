#57:@temp-newt   any (for/about) any rd

if (!player.wizard)
  return player:tell("Permission denied.");
elseif (!valid(who = $string_utils:match_player(dobjstr)))
  return $command_utils:player_match_failed(who, dobjstr);
elseif (dobjstr != who.name && !(dobjstr in who.aliases) && dobjstr != tostr(who))
  return player:tell(tostr("Must be a full name or an object number:  ", who.name, "(", who, ")"));
elseif (who == player)
  player:notify("If you want to newt yourself, you have to do it by hand.");
  return;
elseif (!(howlong = $time_utils:parse_english_time_interval(iobjstr)))
  return player:tell("Can't parse time: ", howlong);
else
  if (who in $login.newted)
    player:notify(tostr(who.name, " appears to already be a newt."));
  else
    $wiz_utils:newt_player(who, "", "For " + iobjstr + ".  ");
  endif
  if (index = $list_utils:iassoc(who, $login.temporary_newts))
    $login.temporary_newts[index][2] = time();
    $login.temporary_newts[index][3] = howlong;
  else
    $login.temporary_newts = {@$login.temporary_newts, {who, time(), howlong}};
  endif
  player:tell(who.name, " (", who, ") will be a newt until ", ctime(time() + howlong));
endif
