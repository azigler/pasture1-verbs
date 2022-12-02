#57:@make-player   any any any rd

"Creates a player.";
"Syntax:  @make-player name email-address comments....";
"Generates a random password for the player.";
if (!player.wizard || callers())
  return E_PERM;
elseif (length(args) < 2)
  player:tell("Syntax:  @make-player name email-address comments....");
  return;
elseif (args[2] == "for")
  "common mistake: @make-player <name> for <email-address> ...";
  args = listdelete(args, 2);
endif
return $wiz_utils:do_make_player(@args);
