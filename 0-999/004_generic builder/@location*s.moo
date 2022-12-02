#4:@location*s   any none none rd

"@locations <thing> - List <thing> and its containers, all the way back to the outermost one.";
set_task_perms(player);
if (!dobjstr)
  what = player;
elseif (!valid(what = player:my_match_object(dobjstr)) && !valid(what = $string_utils:match_player(dobjstr)))
  $command_utils:object_match_failed(dobj, dobjstr);
  return;
endif
player:notify($string_utils:names_of({what, @$object_utils:locations(what)}));
