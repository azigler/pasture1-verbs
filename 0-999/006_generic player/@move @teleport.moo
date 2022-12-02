#6:"@move @teleport"   any (at/to) any rxd

"'@move <object> to <place>' - Teleport an object. Example: '@move trash to #11' to move trash to the closet.";
set_task_perms(caller == this ? this | $no_one);
dobj = this:my_match_object(dobjstr);
iobj = this:my_match_object(iobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr) || (iobj != $nothing && $command_utils:object_match_failed(iobj, iobjstr)))
  return;
endif
if (!$perm_utils:controls(this, dobj) && this != dobj)
  player:tell("You may only @move your own things.");
  return;
endif
old_loc = dobj.location;
if (old_loc == iobj)
  player:tell(dobj.name, " is already ", valid(iobj) ? "in " + iobj.name | "nowhere", ".");
  return;
endif
dobj:moveto(iobj);
if (dobj.location == iobj)
  player:tell("Moved.");
  if (is_player(dobj))
    if (valid(old_loc))
      old_loc:announce_all(dobj.name, " disappears suddenly for parts unknown.");
      if (dobj != player)
        dobj:tell("You have been moved by ", player.name, ".");
      endif
    endif
    if (valid(dobj.location))
      dobj.location:announce(dobj.name, " materializes out of thin air.");
    endif
  endif
elseif (dobj.location == old_loc)
  if ($object_utils:contains(dobj, iobj))
    player:tell(iobj.name, " is inside of ", dobj.name, "!");
  else
    player:tell($string_utils:pronoun_sub("Either %d doesn't want to go, or %i doesn't want to accept %[dpo]."));
  endif
elseif (dobj == player)
  player:tell("You have been deflected from your original destination.");
else
  player:tell($string_utils:pronoun_sub("%D has been deflected from %[dpp] original destination."));
endif
