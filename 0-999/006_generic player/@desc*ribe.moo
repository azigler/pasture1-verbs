#6:@desc*ribe   any as any rd

set_task_perms(player);
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  "...lose...";
elseif (e = dobj:set_description(iobjstr))
  player:notify("Description set.");
else
  player:notify(tostr(e));
endif
