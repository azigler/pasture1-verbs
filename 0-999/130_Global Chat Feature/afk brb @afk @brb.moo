#130:"afk brb @afk @brb"   any none none rxd

if (caller != this && !$perm_utils:controls(cp = caller_perms(), this) && cp != $code_utils:verb_perms())
  return E_PERM;
endif
if (player in this.afk_list)
  this.afk_list = setremove(this.afk_list, player);
  player:tell("You're no longer AFK!");
  player.location:announce_all_but({player}, player.name + " is no longer AFK.");
else
  this.afk_list = {@this.afk_list, player};
  player:tell("You're now AFK! Use the same command to toggle being back.");
  player.location:announce_all_but({player}, player.name + " is now AFK.");
endif
