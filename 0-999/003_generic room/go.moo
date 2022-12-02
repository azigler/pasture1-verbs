#3:go   any any any rxd

if (!args || !(dir = args[1]))
  player:tell("You need to specify a direction.");
  return E_INVARG;
elseif (valid(exit = player.location:match_exit(dir)))
  exit:invoke();
  if (length(args) > 1)
    old_room = player.location;
    "Now give objects in the room we just entered a chance to act.";
    suspend(0);
    if (player.location == old_room)
      "player didn't move or get moved while we were suspended";
      player.location:go(@listdelete(args, 1));
    endif
  endif
elseif (exit == $failed_match)
  player:tell("You can't go that way (", dir, ").");
else
  player:tell("I don't know which direction `", dir, "' you mean.");
endif
