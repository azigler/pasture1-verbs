#71:replace   this none this rxd

"replace the object given to its proper spot (if there is one).";
{object, ?insist = 0} = args;
i = object in this.clean;
if (!i)
  return tostr(object, " is not on the ", this.name, "'s cleanup list");
endif
place = this.destination[i];
if (!($recycler:valid(object) && ($recycler:valid(r = this.requestors[i]) && is_player(r)) && ($recycler:valid(place) || place == #-1) && !(object.location in this.recycle_bins)))
  "object no longer valid (recycled or something), remove it.";
  this.clean = listdelete(this.clean, i);
  this.requestors = listdelete(this.requestors, i);
  this.destination = listdelete(this.destination, i);
  return tostr(object) + " is no longer valid, removed from cleaning list";
endif
oldloc = loc = object.location;
if (object.location == place)
  "already in its place";
  return "";
endif
requestor = $recycler:valid(tr = this.requestors[i]) ? tr | $no_one;
if (insist != "up!")
  if ($code_utils:verb_or_property(object, "in_use"))
    return "Not returning " + object.name + " because it claims to be in use";
  endif
  for thing in (object.contents)
    if (thing:is_listening())
      return "Not returning " + object.name + " because " + thing.name + " is inside";
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  if (valid(loc) && loc != $limbo)
    if (loc:is_listening())
      return "Not returning " + object.name + " because " + loc.name + " is holding it";
    endif
    for y in (loc:contents())
      if (y != object && y:is_listening())
        return "Not returning " + object.name + " because " + y.name + " is in " + loc.name;
      endif
      $command_utils:suspend_if_needed(0);
    endfor
  endif
endif
if (valid(place) && !place:acceptable(object))
  return place.name + " won't accept " + object.name;
endif
try
  requestor:tell("As you requested, the housekeeper tidies ", $string_utils:nn(object), " from ", $string_utils:nn(loc), " to ", $string_utils:nn(place), ".");
  if ($object_utils:has_verb(loc, "announce_all_but"))
    loc:announce_all_but({requestor, object}, "At ", requestor.name, "'s request, the ", this.name, " sneaks in, picks up ", object.name, " and hurries off to put ", $object_utils:has_property(object, "po") && typeof(object.po) == STR ? object.po | "it", " away.");
  endif
except (ANY)
  "Ignore errors";
endtry
fork (0)
  this:moveit(object, place, requestor);
  if ((loc = object.location) == oldloc)
    return object.name + " wouldn't go; " + (!place:acceptable(object) ? " perhaps " + $string_utils:nn(place) + " won't let it in" | " perhaps " + $string_utils:nn(loc) + " won't let go of it");
  endif
  try
    object:tell("The housekeeper puts you away.");
    if ($object_utils:isa(loc, $room))
      loc:announce_all_but({object}, "At ", requestor.name, "'s request, the housekeeper sneaks in, deposits ", object:title(), " and leaves.");
    else
      loc:tell("You notice the housekeeper sneak in, give you ", object:title(), " and leave.");
    endif
  except (ANY)
    "Ignore errors";
  endtry
endfork
return "";
