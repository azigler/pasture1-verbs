#11:"get take"   this none this rxd

"{last_huh}  get/take any";
"a take \"verb\" that works for non-$things.";
set_task_perms(caller_perms());
if (dobj == $nothing)
  player:tell(verb, " what?");
elseif ($command_utils:object_match_failed(dobj, dobjstr))
  "...lose...";
elseif (dobj.location == player)
  player:tell("You already have that!");
elseif (dobj.location != player.location)
  player:tell("I don't see that here.");
else
  dobj:moveto(player);
  if (dobj.location == player)
    player:tell("Taken.");
    player.location:announce(player.name, " takes ", dobj.name, ".");
  else
    player:tell("You can't pick that up.");
  endif
endif
