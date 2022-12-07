#88:disfunc   this none this rxd

"'disfunc ()' - Besides the inherited behavior, notify the player's feature objects that the player has disconnected.";
if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this))
  return E_PERM;
endif
$global_chat:afk();
pass(@args);
"This is forked off to protect :disfunc from buggy :player_disconnected verbs.";
set_task_perms(this);
fork (max(0, $login:current_lag()))
  for feature in (this.features)
    try
      feature:player_disconnected(player, @args);
    except (ANY)
      continue feature;
    endtry
  endfor
endfork
"Last modified Wed Dec  7 07:14:05 2022 UTC by caranov (#133).";
