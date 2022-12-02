#6:@owner   any none none rxd

if ($command_utils:object_match_failed(dobj = player:my_match_object(dobjstr), dobjstr))
  return;
endif
player:tell($string_utils:nn(dobj), " is owned by ", $string_utils:nn(dobj.owner), ".");
