#6:"@remove-feature @rmfeature"   any none none rd

"Usage:  @remove-feature <feature object>";
"Remove an object from your .features list.";
set_task_perms(player);
if (dobjstr)
  features = player.features;
  if (!valid(dobj))
    dobj = $string_utils:match(dobjstr, features, "name", features, "aliases");
  endif
  if (!$command_utils:object_match_failed(dobj, dobjstr))
    if (dobj in features)
      player:remove_feature(dobj);
      player:tell(dobj, " (", dobj.name, ") removed from your features list.");
    else
      player:tell(dobjstr, " is not one of your features.");
    endif
  endif
else
  player:tell("Usage:  @remove-feature <object>");
endif
