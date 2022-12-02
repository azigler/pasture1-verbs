#88:@addr*oom   any none none rxd

"'@addroom <name> <object>', '@addroom <object> <name>', '@addroom <name>', '@addroom <object>', '@addroom' - Add a room to your personal database of teleport destinations. Example: '@addroom Kitchen #24'. Reasonable <object>s are numbers (#17) and 'here'. If you leave out <object>, the object is the current room. If you leave out <name>, the name is the specified room's name. If you leave out both, you get the current room and its name.";
if (!caller && player != this || (caller && callers()[1][3] != this))
  if (!caller)
    player:tell(E_PERM);
  endif
  return E_PERM;
endif
if (!dobjstr)
  object = this.location;
  name = valid(object) ? object.name | "Nowhere";
elseif (command = this:parse_out_object(dobjstr))
  name = command[1];
  object = command[2];
else
  name = dobjstr;
  object = this.location;
endif
if (!valid(object))
  player:tell("This is not a valid location.");
  return E_INVARG;
endif
player:tell("Adding ", name, "(", tostr(object), ") to your database of rooms.");
this.rooms = {@this.rooms, {name, object}};
