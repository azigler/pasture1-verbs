#11:"drop throw"   this none this rxd

"{last_huh}  drop/throw any";
"a drop \"verb\" that works for non-$things.";
set_task_perms(caller_perms());
if (dobj == $nothing)
  player:tell(verb, " what?");
elseif ($command_utils:object_match_failed(dobj, dobjstr))
  "...lose...";
elseif (dobj.location != player)
  player:tell("You don't have that.");
elseif (!player.location:acceptable(dobj))
  player:tell("You can't drop that here.");
else
  dobj:moveto(player.location);
  if (dobj.location == player.location)
    player:tell_lines(verb[1] == "d" ? "Dropped." | "Thrown.");
    player.location:announce(player.name, verb[1] == "d" ? " dropped " | " threw away ", dobj.name, ".");
  else
    player:tell_lines("You can't seem to drop that here.");
  endif
endif
