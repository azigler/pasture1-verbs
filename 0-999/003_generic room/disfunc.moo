#3:disfunc   this none this rxd

if ((cp = caller_perms()) == player || $perm_utils:controls(cp, player) || caller == this)
  this:announce($string_utils:pronoun_sub("%N %<has> disconnected.", player));
  "need the first check since guests don't control themselves";
  if (!$object_utils:isa(player, $guest))
    "guest disfuncs are handled by $guest:disfunc. Don't add them here";
    $housekeeper:move_players_home(player);
  endif
endif
