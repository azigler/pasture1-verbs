#40:@mail   any any any rxd

"@mail <msg-sequence>                --- as in help @mail";
"@mail <msg-sequence> on <recipient> --- shows mail on mailing list or player.";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
if (p = this:parse_mailread_cmd("@mail", args, this:mail_option("@mail") || $mail_agent.("player_default_@mail"), "on"))
  this:set_current_folder(folder = p[1]);
  msg_seq = p[2];
  seq_size = $seq_utils:size(msg_seq);
  if ((lim = player:mail_option("manymsgs")) && (lim <= seq_size && !$command_utils:yes_or_no(tostr("You are about to see ", seq_size, " message headers.  Continue?"))))
    player:notify(tostr("Aborted.  @mailoption manymsgs=", lim));
    return;
  endif
  if (1 != seq_size)
    player:notify(tostr(seq_size, " messages", folder == this ? "" | " on " + $mail_agent:name(folder), ":"));
  endif
  folder:display_seq_headers(msg_seq, @p[3]);
endif
