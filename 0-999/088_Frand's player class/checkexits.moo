#88:checkexits   this none this rxd

"Check a list of exits to see if any of them are in the given room.";
{to_check, room, exits} = args;
for word in (to_check)
  found = room:match_exit(word);
  if (valid(found) && !(found in exits))
    exits = {@exits, found};
  endif
endfor
return exits;
