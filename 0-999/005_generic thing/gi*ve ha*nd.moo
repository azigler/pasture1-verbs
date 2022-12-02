#5:"gi*ve ha*nd"   this (at/to) any rxd

set_task_perms(callers() ? caller_perms() | player);
if (this.location != player)
  player:tell("You don't have that!");
elseif (!valid(player.location))
  player:tell("I see no \"", iobjstr, "\" here.");
elseif ($command_utils:object_match_failed(who = player.location:match_object(iobjstr), iobjstr))
elseif (who.location != player.location)
  player:tell("I see no \"", iobjstr, "\" here.");
elseif (who == player)
  player:tell("Give it to yourself?");
else
  this:moveto(who);
  if (this.location == who)
    player:tell("You hand ", this:title(), " to ", who:title(), ".");
    who:tell(player:titlec(), " ", $gender_utils:get_conj("hands/hand", player), " you ", this:title(), ".");
  else
    player:tell(who:titlec(), " ", $gender_utils:get_conj("does/do", who), " not want that item.");
  endif
endif
