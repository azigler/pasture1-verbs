#40:"@quickr*eply @qreply"   any any any rd

"@qreply <msg> [on *<recipient>] [<flags>...]";
"like @reply only, as in @qsend, we prompt for the message text using ";
"$command_utils:read_lines() rather than invoking the $mail_editor.";
set_task_perms(who = valid(cp = caller_perms()) ? cp | player);
if (!(p = this:parse_mailread_cmd(verb, args, "cur", "on", 1)))
  "...garbled...";
elseif ($seq_utils:size(p[2]) != 1)
  player:notify("You can only answer *one* message at a time.");
elseif (LIST != typeof(flags_replytos = $mail_editor:check_answer_flags("noinclude", @p[4])))
  player:notify_lines({tostr("Usage:  ", verb, " [message-# [on <recipient>]] [flags...]"), "where flags include any of:", "  all        reply to everyone", "  sender     reply to sender only", tostr("  include    include the original message in reply (can't do this for ", verb, ")"), "  noinclude  don't include the original in your reply"});
elseif ("include" in flags_replytos[1])
  player:notify(tostr("Can't include message on a ", verb));
else
  this:set_current_folder(p[1]);
  if (to_subj = $mail_editor:parse_msg_headers(p[1]:messages_in_seq(p[2])[1][2], flags_replytos[1]))
    player:notify(tostr("To:       ", $mail_agent:name_list(@to_subj[1])));
    if (to_subj[2])
      player:notify(tostr("Subject:  ", to_subj[2]));
    endif
    if (replytos = flags_replytos[2])
      player:notify(tostr("Reply-to: ", $mail_agent:name_list(@replytos)));
    endif
    hdrs = {to_subj[2], replytos || {}};
    player:notify("Enter lines of message:");
    message = $command_utils:read_lines_escape((active = player in $mail_editor.active) ? {} | {"@edit"}, {tostr("You are composing mail to ", $mail_agent:name_list(@to_subj[1]), "."), @active ? {} | {"Type `@edit' to take this into the mail editor."}});
    if (typeof(message) == ERR)
      player:notify(tostr(message));
    elseif (message[1] == "@edit")
      $mail_editor:invoke(1, verb, to_subj[1], @hdrs, message[2]);
    elseif (!message[2])
      player:notify("Blank message not sent.");
    else
      result = $mail_agent:send_message(this, to_subj[1], hdrs, message[2]);
      if (result && result[1])
        player:notify(tostr("Message sent to ", $mail_agent:name_list(@listdelete(result, 1)), "."));
      else
        player:notify("Message not sent.");
      endif
    endif
  endif
endif
