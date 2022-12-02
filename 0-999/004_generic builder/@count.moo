#4:@count   any none none rd

if (!dobjstr)
  dobj = player;
elseif ($command_utils:player_match_result(dobj = $string_utils:match_player(dobjstr), dobjstr)[1])
  return;
endif
set_task_perms(player);
if (typeof(dobj.owned_objects) == LIST)
  count = length(dobj.owned_objects);
  player:notify(tostr(dobj.name, " currently owns ", count, " object", count == 1 ? "." | "s."));
  if ($quota_utils.byte_based)
    player:notify(tostr("Total bytes consumed:  ", $string_utils:group_number($quota_utils:get_size_quota(dobj)[2]), "."));
  endif
else
  player:notify(tostr(dobj.name, " is not enrolled in the object ownership system.  Use @countDB instead."));
endif
