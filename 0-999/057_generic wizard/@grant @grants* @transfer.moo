#57:"@grant @grants* @transfer"   any (at/to) any rd

"@grant <object> to <player>";
"@grants <object> to <player>   --- same as @grant but may suspend.";
"@transfer <expression> to <player> -- like 'grant', but evalutes a possible list of objects to transfer, and modifies quota.";
"Ownership of the object changes as in @chown and :set_owner (i.e., .owner and all c properties change).  In addition all verbs and !c properties owned by the original owner change ownership as well.  Finally, for !c properties, instances on descendant objects change ownership (as in :set_property_owner).";
if (!player.wizard || player != this)
  player:notify("Sorry.");
  return;
endif
set_task_perms(player);
if (!iobjstr || !dobjstr)
  return player:notify(tostr("Usage:  ", verb, " <object> to <player>"));
endif
if ($command_utils:player_match_failed(newowner = $string_utils:match_player(iobjstr), iobjstr))
  "...newowner is bogus...";
  return;
endif
if (verb == "@transfer")
  objlist = player:eval_cmd_string(dobjstr, 0);
  if (!objlist[1])
    player:notify(tostr("Had trouble reading `", dobjstr, "': "));
    player:notify_lines(@objlist[2]);
    return;
  elseif (typeof(objlist[2]) == OBJ)
    objlist = objlist[2..2];
  elseif (typeof(objlist[2]) != LIST)
    player:notify(tostr("Value of `", dobjstr, "' is not an object or list:  ", toliteral(objlist[2])));
    return;
  else
    objlist = objlist[2];
  endif
elseif ($command_utils:object_match_failed(object = this:my_match_object(dobjstr), dobjstr))
  "...object is bogus...";
  return;
else
  objlist = {object};
endif
"Used to check for quota of newowner, but doesn't anymore, cuz the quota check doesn't work";
suspendok = verb != "@grant";
player:tell("Transferring ", toliteral(objlist), " to ", $string_utils:nn(newowner));
for object in (objlist)
  $command_utils:suspend_if_needed(0);
  same = object.owner == newowner;
  for vnum in [1..length(verbs(object))]
    info = verb_info(object, vnum);
    if (!(info[1] != object.owner && (valid(info[1]) && is_player(info[1]))))
      same = same && info[1] == newowner;
      set_verb_info(object, vnum, listset(info, newowner, 1));
    endif
  endfor
  for prop in (properties(object))
    if (suspendok && (ticks_left() < 5000 || seconds_left() < 2))
      suspend(0);
    endif
    info = property_info(object, prop);
    if (!(index(info[2], "c") || (info[1] != object.owner && valid(info[1]) && is_player(info[1]))))
      same = same && info[1] == newowner;
      $wiz_utils:set_property_owner(object, prop, newowner, suspendok);
    endif
  endfor
  if (suspendok)
    suspend(0);
  endif
  $wiz_utils:set_owner(object, newowner, suspendok);
  if (same)
    player:notify(tostr(newowner.name, " already owns everything ", newowner.ps, " is entitled to on ", object.name, "."));
  else
    player:notify(tostr("Ownership changed on ", $string_utils:nn(object), ", verb, properties and descendants' properties."));
  endif
endfor
player:notify(tostr(verb, " complete."));
