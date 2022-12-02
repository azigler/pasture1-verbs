#40:@resend   any any any rd

"@resend <msg> [on *<recipient>] to <recipient> [<recipient>...]";
set_task_perms(valid(caller_perms()) ? caller_perms() | player);
"...";
"... parse command...";
"...";
if (!(p = this:parse_mailread_cmd(verb, args, "", "on", 1)))
  "...lose...";
  return;
elseif ($seq_utils:size(sequence = p[2]) != 1)
  player:notify("You can only resend *one* message at a time.");
  return;
elseif (length(p[4]) < 2 || p[4][1] != "to")
  player:notify(tostr("Usage:  ", verb, " [<message>] [on <folder>] to <recip>..."));
  return;
endif
recips = {};
for rs in (listdelete(p[4], 1))
  if ($mail_agent:match_failed(r = $mail_agent:match_recipient(rs), rs))
    return;
  endif
  recips = {@recips, r};
endfor
this:set_current_folder(folder = p[1]);
"...";
"... retrieve original message...";
"...";
{msgnum, msgtxt} = folder:messages_in_seq(sequence)[1];
if (forward_style = this:mail_option("resend_forw"))
  "...message will be from player...";
  pmh = $mail_agent:parse_misc_headers(msgtxt, "Reply-To", "Original-Date", "Original-From");
  orig_from = pmh[3][3] || msgtxt[2];
else
  "...message will be from author...";
  pmh = $mail_agent:parse_misc_headers(msgtxt, "Reply-To", "Original-Date", "Original-From", "Resent-By", "Resent-To");
  orig_from = pmh[3][3];
  from = $mail_agent:parse_address_field(msgtxt[2])[1];
  to = $mail_agent:parse_address_field(msgtxt[3]);
endif
"...";
"... report bogus headers...";
"...";
if (bogus = pmh[2])
  player:notify("Bogus headers stripped from original message:");
  for b in (bogus)
    player:notify("  " + b);
  endfor
  if (!$command_utils:yes_or_no("Continue?"))
    player:notify("Message not resent.");
    return;
  endif
endif
"...";
"... subject, replyto, original-date, original-from ...";
"...";
hdrs = {msgtxt[4], pmh[3][1], {"Original-Date", pmh[3][2] || ctime(msgtxt[1])}, @orig_from ? {{"Original-From", orig_from}} | {}, @pmh[1]};
"...";
"... send it ...";
"...";
if (forward_style)
  result = $mail_agent:send_message(player, recips, hdrs, pmh[4]);
else
  "... resend inserts resent-to and resent-by...";
  result = $mail_agent:resend_message(player, recips, from, to, hdrs, pmh[4]);
endif
"...";
"... report outcome...";
"...";
if (!result)
  player:notify(tostr(result));
elseif (result[1])
  player:notify(tostr("Message ", msgnum, @folder == this ? {} | {" on ", $mail_agent:name(folder)}, " @resent to ", $mail_agent:name_list(@listdelete(result, 1)), "."));
else
  player:notify("Message not resent.");
endif
