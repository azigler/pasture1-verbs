#3:get_nearby_rooms   this none this rxd

{?to = 5} = args;
ret = prevlist = {};
rooms = {this};
currently_at = 0;
while (true)
  if (currently_at >= to)
    break;
  endif
  next = {};
  for room in (rooms)
    if (room != this)
      ret = ret:add(room);
    endif
    for exit in (room:exits())
      if (!valid(exit) && exit.source != room || exit.dest == room || exit.dest == this || !valid(exit.dest))
        continue;
      endif
      next = next:add(exit.dest);
    endfor
  endfor
  rooms = next;
  next = {};
  currently_at = currently_at + 1;
endwhile
return ret;
"Last modified Sat Dec  3 19:06:13 2022 UTC by caranov (#133).";
