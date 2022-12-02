#3:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  if (this == $player_start)
    "... If there are ever multiple rooms, then the question of";
    "....which one is to be $player_start may well be an option of some sort,";
    "... so this goes better here than hardcoded into some specific room:init_for_core verb.";
    move(player, this);
  endif
endif
