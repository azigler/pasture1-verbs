#71:cleanup_list   any none none rxd

if (args)
  if (!valid(who = args[1]))
    return;
  endif
  player:tell(who.name, "'s personal cleanup list:");
else
  who = 0;
  player:tell("Housekeeper's complete cleanup list:");
endif
player:tell("------------------------------------------------------------------");
printed_anything = 0;
objs = this.clean;
reqs = this.requestors;
dest = this.destination;
objfieldwid = length(tostr(max_object())) + 1;
for i in [1..length(objs)]
  $command_utils:suspend_if_needed(2);
  req = $recycler:valid(tr = reqs[i]) ? tr | $no_one;
  ob = objs[i];
  place = dest[i];
  if (who == 0 || req == who || ob.owner == who)
    if (!valid(ob))
      player:tell($string_utils:left(tostr(ob), objfieldwid), $string_utils:left("** recycled **", 50), "(", req.name, ")");
    else
      player:tell($string_utils:left(tostr(ob), objfieldwid), $string_utils:left(ob.name, 26), "=>", $string_utils:left(tostr(place), objfieldwid), (valid(place) ? place.name | "nowhere") || "nowhere", " (", req.name, ")");
    endif
    printed_anything = 1;
  endif
endfor
if (!printed_anything)
  player:tell("** The housekeeper has nothing in the cleanup list.");
endif
player:tell("------------------------------------------------------------------");
