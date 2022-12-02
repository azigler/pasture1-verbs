#88:@ref*use   any any any rd

"'@refuse <action(s)> [ from <player> ] [ for <time> ]' - Refuse all of a list of one or more actions. If a player is given, refuse actions from the player; otherwise, refuse all actions. If a time is specified, refuse the actions for the given amount of time; otherwise, refuse them for a week. If the actions are already refused, then the only their times are adjusted.";
if (!argstr)
  player:tell("@refuse <action(s)> [ from <player> ] [ for <time> ]");
  return;
endif
stuff = this:parse_refuse_arguments(argstr);
if (stuff)
  if (typeof(who = stuff[1]) == OBJ && who != $nothing && !is_player(who))
    player:tell("You must give the name of some player.");
  else
    "'stuff' is now in the form {<origin>, <actions>, <duration>}.";
    if (stuff[3] < 0 || stuff[3] > $maxint - time() - 2)
      stuff[3] = $maxint - time() - 2;
      player:tell("That amount of time is too large.  It has been capped at ", $time_utils:english_time(stuff[3]), ".");
    endif
    this:add_refusal(@stuff);
    player:tell("Refusal of ", this:refusal_origin_to_name(stuff[1]), " for ", $time_utils:english_time(stuff[3]), " added.");
  endif
endif
