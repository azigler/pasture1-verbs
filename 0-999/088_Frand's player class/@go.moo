#88:@go   any none none rxd

"'@go <place>' - Teleport yourself somewhere. Example: '@go liv' to go to the living room.";
dest = this:lookup_room(dobjstr);
if (dest == $failed_match)
  player:tell("There's no such place known.");
else
  this:teleport(player, dest);
endif
