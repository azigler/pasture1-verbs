#47:pri*nt   any none none rd

if (!dobjstr)
  plyr = player;
elseif ($command_utils:player_match_result(plyr = $string_utils:match_player(dobjstr), dobjstr)[1])
  return;
endif
if (plyr != player && !this:readable(plyr in this.active))
  player:tell(plyr.name, "(", plyr, ") has not published anything here.");
elseif (typeof(msg = this:message_with_headers(plyr in this.active)) != LIST)
  player:tell(msg);
else
  player:display_message({(plyr == player ? "Your" | tostr(plyr.name, "(", plyr, ")'s")) + " message so far:", ""}, player:msg_text(@msg));
endif
