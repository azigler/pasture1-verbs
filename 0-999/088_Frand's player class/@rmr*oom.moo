#88:@rmr*oom   any none none rxd

"'@rmroom <roomname>' - Remove a room from your personal database of teleport destinations. Example: '@rmroom library'.";
if (!caller && player != this || (caller && callers()[1][3] != this))
  if (!caller)
    player:tell(E_PERM);
  endif
  return E_PERM;
endif
index = this:index_room(dobjstr);
if (index)
  player:tell("Removing ", this.rooms[index][1], "(", this.rooms[index][2], ").");
  this.rooms = listdelete(this.rooms, index);
else
  player:tell("That room is not in your database of rooms. Check '@rooms'.");
endif
