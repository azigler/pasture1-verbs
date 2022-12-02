#40:"@answer @repl*y"   any any any rd

"@answer <msg> [on *<recipient>] [<flags>...]";
set_task_perms(who = valid(caller_perms()) ? caller_perms() | player);
if (p = this:parse_mailread_cmd(verb, args, "cur", "on", 1))
  if ($seq_utils:size(p[2]) != 1)
    player:notify("You can only answer *one* message at a time.");
  elseif (LIST != typeof(flags_replytos = $mail_editor:check_answer_flags(@p[4])))
    player:notify_lines({tostr("Usage:  ", verb, " [message-# [on <recipient>]] [flags...]"), "where flags include any of:", "  all        reply to everyone", "  sender     reply to sender only", "  include    include the original message in your reply", "  noinclude  don't include the original in your reply"});
  else
    this:set_current_folder(p[1]);
    $mail_editor:invoke(2, verb, p[1]:messages_in_seq(p[2])[1][2], @flags_replytos);
  endif
endif
