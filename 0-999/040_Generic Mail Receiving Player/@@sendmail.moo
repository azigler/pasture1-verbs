#40:@@sendmail   any any any rd

"Syntax: @@sendmail";
"This is intended for use with client editors.  You probably don't want to try using this command manually.";
"Reads a formatted mail message, extracts recipients, subject line and/or reply-to header and sends message without going to the mailroom.  Example:";
"";
"@@send";
"To: Rog (#4292)";
"Subject: random";
"";
"first line";
"second line";
".";
"";
"Currently, header lines must have the same format as in an actual message.";
set_task_perms(player);
if (args)
  player:notify(tostr("The ", verb, " command takes no arguments."));
  $command_utils:read_lines();
  return;
elseif (this != player)
  player:notify(tostr("You can't use ", this.pp, " ", verb, " verb."));
  $command_utils:read_lines();
  return;
endif
msg = $command_utils:read_lines();
end_head = "" in msg || length(msg) + 1;
from = this;
subject = "";
replyto = "";
rcpts = {};
body = msg[end_head + 1..$];
for i in [1..end_head - 1]
  line = msg[i];
  if (index(line, "Subject:") == 1)
    subject = $string_utils:trim(line[9..$]);
  elseif (index(line, "To:") == 1)
    if (!(rcpts = $mail_agent:parse_address_field(line)))
      player:notify("No recipients found in To: line");
      return;
    endif
  elseif (index(line, "Reply-to:") == 1)
    if (!(replyto = $mail_agent:parse_address_field(line)) && $string_utils:trim(line[10..$]))
      player:notify("No address found in Reply-to: line");
      return;
    endif
  elseif (index(line, "From:") == 1)
    "... :send_message() bombs if designated sender != player ...";
    if (!(from = $mail_agent:parse_address_field(line)))
      player:notify("No sender found in From: line");
      return;
    elseif (length(from) > 1)
      player:notify("Multiple senders?");
      return;
    endif
    from = from[1];
  elseif (i = index(line, ":"))
    player:notify(tostr("Unknown header \"", line[1..i], "\""));
    return;
  else
    player:notify("Blank line must separate headers from body.");
    return;
  endif
endfor
if (!rcpts)
  player:notify("No To: line found.");
elseif (!(subject || body))
  player:notify("Blank message not sent.");
else
  player:notify("Sending...");
  result = $mail_agent:send_message(from, rcpts, replyto ? {subject, replyto} | subject, body);
  if (e = result && result[1])
    if (length(result) == 1)
      player:notify("Mail actually went to no one.");
    else
      player:notify(tostr("Mail actually went to ", $mail_agent:name_list(@listdelete(result, 1)), "."));
    endif
  else
    player:notify(tostr(typeof(e) == ERR ? e | "Bogus recipients:  " + $string_utils:from_list(result[2])));
    player:notify("Mail not sent.");
  endif
endif
