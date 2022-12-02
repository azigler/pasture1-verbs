#59:show_object   this none this rxd

set_task_perms(caller_perms());
{object, ?what = {"props", "verbs"}} = args;
player:notify(tostr("Object ID:  ", object));
player:notify(tostr("Name:       ", object.name));
names = {"Parent", "Location", "Owner"};
vals = {parent(object), object.location, object.owner};
for i in [1..length(vals)]
  if (!valid(vals[i]))
    val = "*** NONE ***";
  else
    val = vals[i].name + " (" + tostr(vals[i]) + ")";
  endif
  player:notify(tostr(names[i], ":      "[1..12 - length(names[i])], val));
endfor
line = "Flags:     ";
if (is_player(object))
  line = line + " player";
endif
for flag in ({"programmer", "wizard", "r", "w", "f"})
  if (object.(flag))
    line = line + " " + flag;
  endif
endfor
player:notify(line);
if (player.programmer && (player.wizard || player == object.owner || object.r))
  if ("verbs" in what && (vs = verbs(object)))
    player:notify("Verb definitions:");
    for v in (vs)
      $command_utils:suspend_if_needed(0);
      player:notify(tostr("    ", v));
    endfor
  endif
  if ("props" in what)
    if (ps = properties(object))
      player:notify("Property definitions:");
      for p in (ps)
        $command_utils:suspend_if_needed(0);
        player:notify(tostr("    ", p));
      endfor
    endif
    all_props = $object_utils:all_properties(object);
    if (all_props != {})
      player:notify("Properties:");
      for p in (all_props)
        $command_utils:suspend_if_needed(0);
        strng = `toliteral(object.(p)) ! E_PERM => "(Permission denied.)"';
        player:notify(tostr("    ", p, ": ", strng));
      endfor
    endif
  endif
elseif (player.programmer)
  player:notify("** Can't list properties or verbs: permission denied.");
endif
if (object.contents)
  player:notify("Contents:");
  for o in (object.contents)
    $command_utils:suspend_if_needed(0);
    player:notify(tostr("    ", o.name, " (", o, ")"));
  endfor
endif
