#88:@refusals   none any any rd

"'@refusals' - List your refusals. '@refusals for <player>' - List the given player's refusals.";
if (iobjstr)
  who = $string_utils:match_player(iobjstr);
  if ($command_utils:player_match_failed(who, iobjstr))
    return;
  endif
  if (!$object_utils:has_verb(who, "refusals_text"))
    player:tell("That player does not have the refusal facility.");
    return;
  endif
else
  who = player;
endif
who:remove_expired_refusals();
player:tell_lines(this:refusals_text(who));
