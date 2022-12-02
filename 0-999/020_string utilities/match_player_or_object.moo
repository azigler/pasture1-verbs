#20:match_player_or_object   this none this rxd

"Accepts any number of strings, attempts to match those strings first against objects in the room, and if no objects by those names exist, matches against player names (and \"#xxxx\" style strings regardless of location).  Returns a list of valid objects so found.";
"Unlike $string_utils:match_player, does not include in the list the failed and ambiguous matches; instead has built-in error messages for such objects.  This should probably be improved.  Volunteers?";
if (!args)
  return;
endif
unknowns = {};
objs = {};
"We have to do something icky here.  Parallel walk the victims and args lists.  When it's a valid object, then it's a player.  If it's an invalid object, try to get an object match from the room.  If *that* fails, complain.";
for i in [1..length(args)]
  if (valid(o = player.location:match_object(args[i])))
    objs = {@objs, o};
  else
    unknowns = {@unknowns, args[i]};
  endif
endfor
victims = $string_utils:match_player(unknowns);
for i in [1..length(victims)]
  if (!valid(victims[i]))
    player:tell("Could not find ", unknowns[i], " as either an object or a player.");
  else
    objs = {@objs, victims[i]};
  endif
endfor
return objs;
