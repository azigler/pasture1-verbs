#88:index_room   this none this rxd

"'index_room (<room name>)' - Look up a room in your personal database of room names, returning its index in the list. Return 0 if it is not in the list. If the room name is the empty string, then only exact matches are considered; otherwise, a leading match is good enough.";
room = tostr(args[1]);
size = length(room);
index = 1;
match = 0;
for item in (this.rooms)
  item_name = item[1];
  if (room == item_name)
    return index;
  elseif (size && length(item_name) >= size && room == item_name[1..size])
    match = index;
  endif
  index = index + 1;
endfor
return match;
