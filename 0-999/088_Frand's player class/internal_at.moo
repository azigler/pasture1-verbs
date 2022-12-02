#88:internal_at   this none this rxd

"'internal_at (<argument string>)' - Perform the function of @at. The argument string is whatever the user typed after @at. This is factored out so that other verbs can call it.";
where = $string_utils:trim(args[1]);
if (where)
  if (where[1] == "#")
    result = toobj(where);
    if (!valid(result) && result != #-1)
      player:tell("That object does not exist.");
      return;
    endif
  else
    result = this:lookup_room(where);
    if (!valid(result))
      result = $string_utils:match_player(where);
      if (!valid(result))
        player:tell("That is neither a player nor a room name.");
        return;
      endif
    endif
  endif
  if (valid(result) && !$object_utils:isa(result, $room))
    result = result.location;
  endif
  this:do_at(result);
else
  this:do_at_all();
endif
