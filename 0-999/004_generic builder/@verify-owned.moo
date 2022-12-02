#4:@verify-owned   none none none rd

for x in (player.owned_objects)
  if (!valid(x) || x.owner != player)
    player.owned_objects = setremove(player.owned_objects, x);
    if (valid(x))
      player:tell("Removing ", x.name, "(", x, "), owned by ", valid(x.owner) ? x.owner.name | "<recycled player>", " from your .owned_objects property.");
    else
      player:tell("Removing invalid object ", x, " from your .owned_objects property.");
    endif
  endif
  $command_utils:suspend_if_needed(2, tostr("Suspending @verify-owned ... ", x));
endfor
player:tell(".owned_objects property verified.");
