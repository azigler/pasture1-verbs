#4:@check-chp*arent   any (at/to) any rd

"Copied from generic programmer (#217):@check-chparent by ur-Rog (#6349) Sun Nov  8 22:13:53 1992 PST";
"@check-chparent object to newparent";
"checks for property name conflicts that would make @chparent bomb.";
set_task_perms(player);
if (!(dobjstr && iobjstr))
  player:notify(tostr("Usage:  ", verb, " <object> to <newparent>"));
elseif ($command_utils:object_match_failed(object = player:my_match_object(dobjstr), dobjstr))
  "...bogus object...";
elseif ($command_utils:object_match_failed(parent = player:my_match_object(iobjstr), iobjstr))
  "...bogus new parent...";
elseif (player != this)
  player:notify(tostr(E_PERM));
elseif (typeof(result = $object_utils:property_conflicts(object, parent)) == ERR)
  player:notify(tostr(result));
elseif (result)
  su = $string_utils;
  player:notify("");
  player:notify(su:left("Property", 30) + "Also Defined on");
  player:notify(su:left("--------", 30) + "---------------");
  for r in (result)
    player:notify(su:left(tostr(parent, ".", r[1]), 30) + su:from_list(listdelete(r, 1), " "));
    $command_utils:suspend_if_needed(0);
  endfor
else
  player:notify("No property conflicts found.");
endif
