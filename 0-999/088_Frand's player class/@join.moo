#88:@join   any none none rxd

"'@join <player>' - Teleport yourself to the location of any player, whether connected or not.";
if (dobjstr == "")
  player:tell("Usage: @join <player>. For example, '@join frand'.");
  return;
endif
target = $string_utils:match_player(dobjstr);
$command_utils:player_match_result(target, dobjstr);
if (valid(target))
  if (target == this)
    if (player == this)
      player:tell("There is little need to join yourself, unless you are split up.");
    else
      player:tell("No thank you. Please get your own join verb.");
    endif
    return;
  endif
  dest = target.location;
  msg = this:enlist(this:join_msg());
  editing = $object_utils:isa(dest, $generic_editor);
  if (editing)
    dest = dest.original[target in dest.active];
    editing_msg = "%N is editing at the moment. You can wait here until %s is done.";
    if (player.location == dest)
      msg = {editing_msg};
    else
      msg = {@msg, editing_msg};
    endif
  endif
  if (msg && (player.location != dest || editing))
    player:tell_lines($string_utils:pronoun_sub(msg, target));
  elseif (player.location == dest)
    player:tell("OK, you're there. You didn't need to actually move, though.");
    return;
  endif
  this:teleport(player, dest);
endif
