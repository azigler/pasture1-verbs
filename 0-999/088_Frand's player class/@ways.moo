#88:@ways   any none none rxd

"'@ways', '@ways <room>' - List any obvious exits from the given room (or this room, if none is given).";
if (dobjstr)
  room = dobj;
else
  room = this.location;
endif
if (!valid(room) || !($room in $object_utils:ancestors(room)))
  player:tell("You can only pry into the exits of a room.");
  return;
endif
exits = {};
if ($object_utils:has_verb(room, "obvious_exits"))
  exits = room:obvious_exits();
endif
exits = this:checkexits(this:obvious_exits(), room, exits);
exits = this:findexits(room, exits);
this:tell_ways(exits, room);
