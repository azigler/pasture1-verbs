#88:confunc   this none this rxd

"'confunc ()' - Besides the inherited behavior, notify the player's feature objects that the player has connected.";
if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this))
  return E_PERM;
endif
pass(@args);
set_task_perms(this);
for feature in (this.features)
  try
    feature:player_connected(player, @args);
  except (E_VERBNF)
    continue feature;
  except id (ANY)
    player:tell("Feature initialization failure for ", feature, ": ", id[2], ".");
  endtry
  $command_utils:suspend_if_needed(0);
endfor
