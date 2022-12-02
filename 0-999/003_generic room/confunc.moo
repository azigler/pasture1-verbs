#3:confunc   this none this rxd

if ((cp = caller_perms()) == player || $perm_utils:controls(cp, player) || caller == this)
  "Need the first check because guests don't control themselves";
  this:look_self(player.brief);
  this:announce($string_utils:pronoun_sub("%N %<has> connected.", player));
endif
