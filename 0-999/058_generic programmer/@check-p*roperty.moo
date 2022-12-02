#58:@check-p*roperty   any none none rd

"@check-prop object.property";
"  checks for descendents defining the given property.";
set_task_perms(player);
if (!(spec = $code_utils:parse_propref(dobjstr)))
  player:notify(tostr("Usage:  ", verb, " <object>.<prop-name>"));
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  "...bogus object...";
elseif (!($perm_utils:controls(player, object) || object.w))
  player:notify("You can't create a property on that object anyway.");
elseif ($object_utils:has_property(object, prop = spec[2]))
  player:notify("That object already has that property.");
elseif (olist = $object_utils:descendants_with_property_suspended(object, prop))
  player:notify("The following descendents have this property defined:");
  player:notify("  " + $string_utils:from_list(olist, " "));
else
  player:notify("No property name conflicts found.");
endif
