#4:@contents   any none none rd

"'@contents <obj> - list the contents of an object, with object numbers.";
set_task_perms(player);
if (!dobjstr)
  dobj = player.location;
else
  dobj = player:my_match_object(dobjstr);
endif
if ($command_utils:object_match_failed(dobj, dobjstr))
else
  contents = dobj.contents;
  if (contents)
    player:notify(tostr(dobj:title(), "(", dobj, ") contains:"));
    player:notify(tostr($string_utils:names_of(contents)));
  else
    player:notify(tostr(dobj:title(), "(", dobj, ") contains nothing."));
  endif
endif
