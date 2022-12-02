#6:@move-new   any any any rd

"'@move <object> to <place>' - Teleport an object. Example: '@move trash to #11' to move trash to the closet.";
set_task_perms(caller == this ? this | $no_one);
if (prepstr != "to" || !iobjstr)
  player:tell("Usage: @move <object> to <location>");
  return;
endif
if (!dobjstr || dobjstr == "me")
  dobj = this;
else
  dobj = here:match_object(dobjstr);
  if (!valid(dobj))
    dobj = player:my_match_object(dobjstr);
  endif
endif
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
endif
iobj = this:lookup_room(iobjstr);
if (iobj != $nothing && $command_utils:object_match_failed(iobj, iobjstr))
  return;
endif
if (!player.programmer && !$perm_utils:controls(this, dobj) && this != dobj)
  player:tell("You may only @move your own things.");
  return;
endif
this:teleport(dobj, iobj);
