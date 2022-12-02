#40:@forward   any any any rxd

"@forward <msg> [on *<recipient>] to <recipient> [<recipient>...]";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
if (!(p = this:parse_mailread_cmd(verb, args, "", "on", 1)))
  "...lose...";
  return;
elseif ($seq_utils:size(sequence = p[2]) != 1)
  player:notify("You can only forward *one* message at a time.");
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
m = folder:messages_in_seq(sequence)[1];
msgnum = m[1];
msgtxt = m[2];
from = msgtxt[2];
if (msgtxt[4] != " ")
  subject = tostr("[", from, ":  ", msgtxt[4], "]");
elseif ((h = "" in msgtxt) && h < length(msgtxt))
  subject = tostr("[", from, ":  `", msgtxt[h + 1][1..min(20, $)], "']");
else
  subject = tostr("[", from, "]");
endif
result = $mail_agent:send_message(player, recips, subject, $mail_agent:to_text(@msgtxt));
if (!result)
  player:notify(tostr(result));
elseif (result[1])
  player:notify(tostr("Message ", msgnum, @folder == this ? {} | {" on ", $mail_agent:name(folder)}, " @forwarded to ", $mail_agent:name_list(@listdelete(result, 1)), "."));
else
  player:notify("Message not sent.");
endif
