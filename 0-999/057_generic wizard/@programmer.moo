#57:@programmer   any none none rd

set_task_perms(player);
dobj = $string_utils:match_player(dobjstr);
if (dobj == $nothing)
  player:notify(tostr("Usage:  ", verb, " <playername>"));
elseif ($command_utils:player_match_result(dobj, dobjstr)[1])
elseif ($wiz_utils:check_prog_restricted(dobj))
  return player:notify(tostr("Sorry, ", dobj.name, " is not allowed to be a programmer."));
elseif (dobj.description == $player.description && !$command_utils:yes_or_no($string_utils:pronoun_sub("@Programmer %d despite %[dpp] lack of description?")))
  player:notify(tostr("Okay, leaving ", dobj.name, " !programmer."));
  return;
elseif (result = $wiz_utils:set_programmer(dobj))
  player:notify(tostr(dobj.name, " (", dobj, ") is now a programmer.  ", dobj.ppc, " quota is currently ", $quota_utils:get_quota(dobj), "."));
  player:notify(tostr(dobj.name, " and the other wizards have been notified."));
  if (msg = this:programmer_victim_msg())
    dobj:notify(msg);
  endif
  if ($object_utils:isa(dobj.location, $room) && (msg = this:programmer_msg()))
    dobj.location:announce_all_but({dobj}, msg);
  endif
elseif (result == E_NONE)
  player:notify(tostr(dobj.name, " (", dobj, ") is already a programmer..."));
else
  player:notify(tostr(result));
endif
