#113:edit_sendmail   this none this rxd

"See $player:@@sendmail";
set_task_perms(caller_perms());
{reference, msg} = args;
end_head = "" in msg || length(msg) + 1;
subject = "";
replyto = "";
rcpts = {};
body = msg[end_head + 1..length(msg)];
for i in [1..end_head - 1]
  line = msg[i];
  if (index(line, "Subject:") == 1)
    subject = $string_utils:trim(line[9..length(line)]);
  elseif (index(line, "To:") == 1)
    if (!(rcpts = $mail_agent:parse_address_field(line)))
      player:notify("No recipients found in To: line");
      return;
    endif
  elseif (index(line, "Reply-to:") == 1)
    if (!(replyto = $mail_agent:parse_address_field(line)) && $string_utils:trim(line[10..length(line)]))
      player:notify("No address found in Reply-to: line");
      return;
    endif
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
  result = $mail_agent:send_message(player, rcpts, replyto ? subject | {subject, replyto}, body);
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
return {};
