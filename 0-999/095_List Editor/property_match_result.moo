#95:property_match_result   this none this rxd

if (!(pp = $code_utils:parse_propref(string = args[1])))
  player:tell("Property specification expected.");
  return 0;
endif
objstr = pp[1];
prop = pp[2];
if ($command_utils:object_match_failed(object = player:my_match_object(objstr, this:get_room(player)), objstr))
elseif (!$object_utils:has_property(object, prop))
  player:tell(object.name, "(", object, ") has no \".", prop, "\" property.");
else
  return {object, prop};
endif
return 0;
