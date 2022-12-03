#6:peer   any any any rxd

"Usage: PEER [exit]";
"Shows the description of the room located at [exit].";
if (!valid(player.location) || !isa(player.location, $room))
  return player:tell("You can't see much here.");
elseif ((exits = player.location:obvious_exits()) == {})
  return player:tell("There are no exits here.");
endif
if (!args)
  player:tell("Peer in which direction?");
  direction = exits[$menu_utils:menu(exits)];
else
  direction = player.location:match_exit(argstr);
endif
if (direction == $failed_match)
  return player:tell("That doesn't appear to be an exit.");
elseif (!valid(direction) || !isa(direction, $exit))
  return player:tell("You can't see much in that direction.");
elseif (!valid(direction.dest) || !isa(direction.dest, $room))
  return player:tell("That exit doesn't appear to go anywhere.");
else
  player:tell("You peer ", direction:title(), " and see...");
  player:tell("");
  direction.dest:look_self();
endif
