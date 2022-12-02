#6:@age   any none none rd

if (dobjstr == "" || dobj == player)
  dobj = player;
else
  dobj = $string_utils:match_player(dobjstr);
  if (!valid(dobj))
    $command_utils:player_match_failed(dobj, dobjstr);
    return;
  endif
endif
time = dobj.first_connect_time;
if (time == $maxint)
  duration = time() - dobj.last_disconnect_time;
  if (duration < 86400)
    notice = $string_utils:from_seconds(duration);
  else
    notice = $time_utils:english_time(duration / 86400 * 86400);
  endif
  player:notify(tostr(dobj.name, " has never connected.  It was created ", notice, " ago."));
elseif (time == 0)
  player:notify(tostr(dobj.name, " first connected before initial connections were being recorded."));
else
  player:notify(tostr(dobj.name, " first connected on ", ctime(time)));
  duration = time() - time;
  if (duration < 86400)
    notice = $string_utils:from_seconds(duration);
  else
    notice = $time_utils:english_time(duration / 86400 * 86400);
  endif
  player:notify(tostr($string_utils:pronoun_sub("%S %<is> ", dobj), notice, " old."));
endif
