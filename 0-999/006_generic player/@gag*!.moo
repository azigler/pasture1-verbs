#6:@gag*!   any any any rd

set_task_perms(player);
if (player != this)
  player:notify("Permission denied.");
  return;
endif
if (!args)
  player:notify(tostr("Usage:  ", verb, " <player or object> [<player or object>...]"));
  return;
endif
victims = $string_utils:match_player_or_object(@args);
changed = 0;
for p in (victims)
  if (p in player.gaglist)
    player:notify(tostr("You are already gagging ", p.name, "."));
  elseif (p == player)
    player:notify("Gagging yourself is a bad idea.");
  elseif (children(p) && verb != "@gag!")
    player:tell("If you really want to gag all descendents of ", $string_utils:nn(p), ", use `@gag! ", p, "' instead.");
  else
    changed = 1;
    player:set_gaglist(@setadd(this.gaglist, p));
  endif
endfor
if (changed)
  this:("@listgag")();
endif
