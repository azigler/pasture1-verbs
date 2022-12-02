#88:lookup_room   this none this rxd

"Look up a room in your personal database of room names, returning its object number. If it's not in your database, it checks to see if it's a number or a nearby object.";
room = args[1];
if (room == "home")
  return player.home;
elseif (room == "me")
  return player;
elseif (room == "here")
  return player.location;
elseif (!room)
  return $failed_match;
endif
index = this:index_room(room);
if (index)
  return this.rooms[index][2];
else
  return this:my_match_object(room);
  "old code no longer used, 2/11/96 Heathcliff";
  source = player.location;
  if (!(valid(source) && $room in $object_utils:ancestors(source)))
    source = $room;
  endif
  return source:match_object(room);
endif
