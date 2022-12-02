#88:@move   any any any rxd

"'@move <object> to <place>' - Teleport an object. Example: '@move trash to #11' to move trash to the closet.";
here = player.location;
if (prepstr != "to" || !iobjstr)
  player:tell("Usage: @move <object> to <location>");
  return;
endif
if (!dobjstr || dobjstr == "me")
  thing = this;
else
  thing = `here:match_object(dobjstr) ! E_VERBNF, E_INVIND => $failed_match';
  if (thing == $failed_match)
    thing = player:my_match_object(dobjstr);
  endif
endif
if ($command_utils:object_match_failed(thing, dobjstr))
  return;
endif
if (!player.programmer && (thing.owner != player && thing != player))
  player:tell("You can only move your own objects.");
  return;
endif
dest = this:lookup_room(iobjstr);
if (dest == #-1 || !$command_utils:object_match_failed(dest, iobjstr))
  this:teleport(thing, dest);
endif
