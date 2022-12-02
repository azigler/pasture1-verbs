#4:@sort-owned*-objects   any none none rd

"$player:owned_objects -- sorts a players .owned_objects property in ascending";
"order so it looks nice on @audit.";
if (player != this)
  return E_PERM;
endif
if (typeof(player.owned_objects) == LIST)
  if (!dobjstr || index("object", dobjstr) == 1)
    ret = $list_utils:sort_suspended(0, player.owned_objects);
  elseif (index("size", dobjstr) == 1)
    ret = $list_utils:reverse_suspended($list_utils:sort_suspended(0, player.owned_objects, $list_utils:slice($list_utils:map_prop(player.owned_objects, "object_size"))));
  endif
  if (typeof(ret) == LIST)
    player.owned_objects = ret;
    player:tell("Your .owned_objects list has been sorted.");
    return 1;
  else
    player:tell("Something went wrong. .owned_objects not sorted.");
    return 0;
  endif
else
  player:tell("You are not enrolled in .owned_objects scheme, sorry.");
endif
