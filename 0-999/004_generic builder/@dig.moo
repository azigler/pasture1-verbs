#4:@dig   any any any rd

set_task_perms(player);
nargs = length(args);
if (nargs == 1)
  room = args[1];
  exit_spec = "";
elseif (nargs >= 3 && args[2] == "to")
  exit_spec = args[1];
  room = $string_utils:from_list(args[3..$], " ");
elseif (argstr && !prepstr)
  room = argstr;
  exit_spec = "";
else
  player:notify(tostr("Usage:  ", verb, " <new-room-name>"));
  player:notify(tostr("    or  ", verb, " <exit-description> to <new-room-name-or-old-room-object-number>"));
  return;
endif
if (room != tostr(other_room = toobj(room)))
  room_kind = player:build_option("dig_room");
  if (room_kind == 0)
    room_kind = $room;
  endif
  other_room = player:_create(room_kind);
  if (typeof(other_room) == ERR)
    player:notify(tostr("Cannot create new room as a child of ", $string_utils:nn(room_kind), ": ", other_room, ".  See `help @build-options' for information on how to specify the kind of room this command tries to create."));
    return;
  endif
  for f in ($string_utils:char_list(player:build_option("create_flags") || ""))
    other_room.(f) = 1;
  endfor
  other_room.name = room;
  other_room.aliases = {room};
  move(other_room, $nothing);
  player:notify(tostr(other_room.name, " (", other_room, ") created."));
elseif (nargs == 1)
  player:notify("You can't dig a room that already exists!");
  return;
elseif (!valid(player.location) || !($room in $object_utils:ancestors(player.location)))
  player:notify(tostr("You may only use the ", verb, " command from inside a room."));
  return;
elseif (!valid(other_room) || !($room in $object_utils:ancestors(other_room)))
  player:notify(tostr(other_room, " doesn't look like a room to me..."));
  return;
endif
if (exit_spec)
  exit_kind = player:build_option("dig_exit");
  if (exit_kind == 0)
    exit_kind = $exit;
  endif
  exits = $string_utils:explode(exit_spec, "|");
  if (length(exits) < 1 || length(exits) > 2)
    player:notify("The exit-description must have the form");
    player:notify("     [name:]alias,...,alias");
    player:notify("or   [name:]alias,...,alias|[name:]alias,...,alias");
    return;
  endif
  do_recreate = !player:build_option("bi_create");
  to_ok = $building_utils:make_exit(exits[1], player.location, other_room, do_recreate, exit_kind);
  if (to_ok && length(exits) == 2)
    $building_utils:make_exit(exits[2], other_room, player.location, do_recreate, exit_kind);
  endif
endif
