#88:wh*isper   any (at/to) this rxd

"'whisper <message> to <this player>' - Whisper a message to this player which nobody else can see.";
if (this:refuses_action(player, "whisper"))
  player:tell(this:whisper_refused_msg());
  this:report_refusal(player, "You just refused a whisper from ", player.name, ".");
else
  pass(@args);
endif
