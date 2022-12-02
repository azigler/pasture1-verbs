#11:"give hand"   this none this rxd

"{last_huh}  give any to any";
"a give \"verb\" that works for non-$things.";
set_task_perms(caller_perms());
if (verb == "give" && dobjstr == "up" && !prepstr)
  player:tell("Try this instead: @quit");
elseif (dobj == $nothing)
  player:tell("What do you want to give?");
elseif (iobj == $nothing)
  player:tell("To whom/what do you want to give it?");
elseif ($command_utils:object_match_failed(dobj, dobjstr) || $command_utils:object_match_failed(iobj, iobjstr))
  "...lose...";
elseif (dobj.location != player)
  player:tell("You don't have that!");
elseif (iobj.location != player.location)
  player:tell("I don't see ", iobj.name, " here.");
else
  dobj:moveto(iobj);
  if (dobj.location == iobj)
    player:tell("You give ", dobj:title(), " to ", iobj.name, ".");
    iobj:tell(player.name, " gives you ", dobj:title(), ".");
  else
    player:tell("Either that doesn't want to be given away or ", iobj.name, " doesn't want it.");
  endif
endif
