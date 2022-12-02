#4:@recreate   any as any rd

"@recreate <object> as <parent-class> named [name:]alias,alias,...";
"  effectively recycles and creates <object> all over again.";
set_task_perms(player);
as = prepstr in args;
named = "named" in args;
if (named <= as + 1 || named == length(args))
  named = "called" in args;
endif
if (named <= as + 1 || named == length(args))
  player:notify_lines({tostr("Usage:  ", verb, " <object> as <parent-class> named [name:]alias,...,alias"), "", "where <parent-class> is one of the standard classes ($note, $letter, $thing, or $container) or an object number (e.g., #999), or the name of some object in the current room.  The [name:]alias... specification is as in @create.", "", "You can use \"called\" instead of \"named\", if you wish."});
  return;
elseif ($command_utils:object_match_failed(dobj = player:my_match_object(dobjstr), dobjstr, 1))
  return;
elseif (valid(dobj) && is_player(dobj))
  player:notify("You really *don't* want to do that!");
  return;
endif
parentstr = $string_utils:from_list(args[as + 1..named - 1], " ");
namestr = $string_utils:from_list(args[named + 1..$], " ");
if (parentstr[1] == "$")
  parent = $string_utils:literal_object(parentstr);
  if (parent == $failed_match || typeof(parent) != OBJ)
    player:notify(tostr("\"", parentstr, "\" does not name an object."));
    return;
  endif
else
  parent = player:my_match_object(parentstr);
  if ($command_utils:object_match_failed(parent, parentstr))
    return;
  endif
endif
if (!(e = $building_utils:recreate(dobj, parent)))
  player:notify(tostr(e));
  return;
endif
for f in ($string_utils:char_list(player:build_option("create_flags") || ""))
  dobj.(f) = 1;
endfor
"move() shouldn't, but could, bomb. Say if player has a stupid :accept";
`move(dobj, player) ! ANY';
$building_utils:set_names(dobj, namestr);
if ((other_names = setremove(dobj.aliases, dobj.name)) != {})
  aka = " (aka " + $string_utils:english_list(other_names) + ")";
else
  aka = "";
endif
player:notify(tostr("Object number ", dobj, " is now ", dobj.name, aka, " with parent ", parent.name, " (", parent, ")."));
