#40:"@quick*send @qsend"   any any any rd

"Syntax: @quicksend <recipients(s)> [subj=<text>] [<message>]";
"Sends the recipients(s) a quick message, wit{out having to go to the mailroom. If there is more than one recipients, place them all in quotes. If the subj contains spaces, place it in quotes.";
"To put line breaks in the message, use a caret (^).";
"If no message is given, prompt for lines of message.";
"Examples:";
"@quicksend Alice subj=\"Wonderland is neat!\" Have you checked out the Wonderland scenario yet? I think you'd like it!";
"@quicksend \"Ethel Fred\" Have you seen Lucy around?^--Ricky";
set_task_perms($object_utils:isa(player, $guest) ? player.owner | player);
if (!args)
  player:notify(tostr("Usage: ", verb, " <recipients(s)> [subj=<text>] [<message>]"));
  return E_INVARG;
elseif (this != player)
  player:notify(tostr("You can't use ", this.pp, " @quicksend verb."));
  return E_PERM;
elseif (!(recipients = $mail_editor:parse_recipients({}, $string_utils:explode(args[1]))))
  return;
else
  if (length(args) > 1 && ((eq = index(args[2], "=")) && index("subject", args[2][1..eq - 1]) == 1))
    subject = $string_utils:trim(args[2][eq + 1..$]);
    ws = $string_utils:word_start(argstr);
    argstr = argstr[1..ws[1][2]] + argstr[ws[2][2] + 1..$];
    args = listdelete(args, 2);
  else
    subject = "";
  endif
  if (length(args) > 1)
    unbroken = argstr[argstr[1] == "\"" ? length(args[1]) + 4 | length(args[1]) + 2..$] + "^";
    message = {};
    while (unbroken)
      if (i = index(unbroken, "^"))
        message = {@message, unbroken[1..i - 1]};
      endif
      unbroken = unbroken[i + 1..$];
    endwhile
  else
    if (!(subject || player:mail_option("nosubject")))
      player:notify("Subject:");
      subject = $command_utils:read();
    endif
    player:notify("Enter lines of message:");
    message = $command_utils:read_lines_escape((active = player in $mail_editor.active) ? {} | {"@edit"}, {tostr("You are composing mail to ", $mail_agent:name_list(@recipients), "."), @active ? {} | {"Type `@edit' to take this into the mail editor."}});
    if (typeof(message) == ERR)
      player:notify(tostr(message));
      return;
    elseif (message[1] == "@edit")
      $mail_editor:invoke(1, verb, recipients, subject, {}, message[2]);
      return;
    elseif (!(message[2] || subject))
      player:notify("Blank message not sent.");
      return;
    endif
    message = message[2];
  endif
  result = $mail_agent:send_message(this, recipients, subject, message);
  if (result && result[1])
    player:notify(tostr("Message sent to ", $mail_agent:name_list(@listdelete(result, 1)), "."));
  else
    player:notify("Message not sent.");
  endif
endif
