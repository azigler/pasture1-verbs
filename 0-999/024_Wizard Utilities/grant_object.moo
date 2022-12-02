#24:grant_object   this none this rxd

":grant_object(what, towhom);";
"Ownership of the object changes as in @chown and :set_owner (i.e., .owner and all c properties change).  In addition all verbs and !c properties owned by the original owner change ownership as well.  Finally, for !c properties, instances on descendant objects change ownership (as in :set_property_owner).";
if (!caller_perms().wizard)
  return E_PERM;
endif
{object, newowner} = args;
if (!is_player(newowner))
  return E_INVARG;
endif
same = object.owner == newowner;
for vnum in [1..length(verbs(object))]
  info = verb_info(object, vnum);
  if (!(info[1] != object.owner && (valid(info[1]) && is_player(info[1]))))
    same = same && info[1] == newowner;
    set_verb_info(object, vnum, listset(info, newowner, 1));
  endif
endfor
for prop in (properties(object))
  $command_utils:suspend_if_needed(0);
  info = property_info(object, prop);
  if (!(index(info[2], "c") || (info[1] != object.owner && valid(info[1]) && is_player(info[1]))))
    same = same && info[1] == newowner;
    $wiz_utils:set_property_owner(object, prop, newowner, 1);
  endif
endfor
suspend(0);
$wiz_utils:set_owner(object, newowner, 1);
return same ? "nothing changed" | "grant changed";
