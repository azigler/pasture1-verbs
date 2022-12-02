#4:@create   any any any rd

set_task_perms(player);
nargs = length(args);
pos = "named" in args;
if (pos <= 1 || pos == nargs)
  pos = "called" in args;
endif
if (pos <= 1 || pos == nargs)
  player:notify("Usage:  @create <parent-class> named [name:]alias,...,alias");
  player:notify("   or:  @create <parent-class> named name-and-alias,alias,...,alias");
  player:notify("");
  player:notify("where <parent-class> is one of the standard classes ($note, $letter, $thing, or $container) or an object number (e.g., #999), or the name of some object in the current room.");
  player:notify("You can use \"called\" instead of \"named\", if you wish.");
  return;
endif
parentstr = $string_utils:from_list(args[1..pos - 1], " ");
namestr = $string_utils:from_list(args[pos + 1..$], " ");
if (!namestr)
  player:notify("You must provide a name.");
  return;
endif
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
object = player:_create(parent);
if (typeof(object) == ERR)
  player:notify(tostr(object));
  return;
endif
for f in ($string_utils:char_list(player:build_option("create_flags") || ""))
  object.(f) = 1;
endfor
"move() shouldn't, but could bomb. Say if player has a stupid :accept";
`move(object, player) ! ANY';
$building_utils:set_names(object, namestr);
if ((other_names = setremove(object.aliases, object.name)) != {})
  aka = " (aka " + $string_utils:english_list(other_names) + ")";
else
  aka = "";
endif
player:notify(tostr("You now have ", object.name, aka, " with object number ", object, " and parent ", parent.name, " (", parent, ")."));
