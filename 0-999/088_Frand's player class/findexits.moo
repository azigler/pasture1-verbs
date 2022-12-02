#88:findexits   this none this rxd

"Add to the 'exits' list any exits in the room which have a single-letter alias.";
{room, exits} = args;
alphabet = "abcdefghijklmnopqrstuvwxyz0123456789";
for i in [1..length(alphabet)]
  found = room:match_exit(alphabet[i]);
  if (valid(found) && !(found in exits))
    exits = {@exits, found};
  endif
endfor
return exits;
