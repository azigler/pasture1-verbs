#6:"@add-feature @addfeature"   any none none rd

"Usage:";
"  @add-feature";
"  @add-feature <feature object>";
"Modified 10 Oct 94, by Michele, to check the warehouse and match.";
"Lists all features or adds an object to your features list.";
set_task_perms(player);
if (dobjstr)
  if (dobj == $failed_match)
    dobj = $feature.warehouse:match_object(dobjstr);
  endif
  if (!$command_utils:object_match_failed(dobj, dobjstr))
    if (dobj in player.features)
      player:tell(dobjstr, " is already one of your features.");
    elseif (player:add_feature(dobj))
      player:tell(dobj, " (", dobj.name, ") added as a feature.");
    else
      player:tell("You can't seem to add ", dobj, " (", dobj.name, ") to your features list.");
    endif
  endif
else
  player:tell("Usage:  @add-feature <object>");
  if (length($feature.warehouse.contents) < 20)
    player:tell("Available features include:");
    player:tell("--------------------------");
    fe = {};
    for c in ($feature.warehouse.contents)
      fe = {c in player.features ? c:title() + " (*)" | c:title()};
      player:tell("  " + $string_utils:english_list(fe));
    endfor
    player:tell("--------------------------");
    player:tell("A * after the feature name means that you already have that feature.");
  endif
endif
