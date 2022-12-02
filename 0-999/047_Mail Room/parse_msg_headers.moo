#47:parse_msg_headers   this none this rxd

"parse_msg_headers(msg,flags)";
"  parses msg to extract reply recipients and construct a subject line";
"  if the \"all\" flag is present, reply goes to all of the original recipients";
"  returns a list {recipients, subjectline} or 0 in case of error.";
{msg, flags} = args;
replyall = "all" in flags;
objects = {};
if ("followup" in flags)
  "...look for first non-player recipient in To: line...";
  for o in ($mail_agent:parse_address_field(msg[3]))
    if (objects)
      break o;
    elseif ($object_utils:isa(o, $mail_recipient))
      objects = {o};
    endif
  endfor
endif
objects = objects || $mail_agent:parse_address_field(msg[2] + (replyall ? msg[3] | ""));
for line in (msg[5..("" in {@msg, ""}) - 1])
  if (rt = index(line, "Reply-to:") == 1)
    objects = $mail_agent:parse_address_field(line);
  endif
endfor
recips = {};
for o in (objects)
  if (o == #0)
    player:tell("Sorry, but I can't parse the header of that message.");
    return 0;
  elseif (!valid(o) || !(is_player(o) || $mail_recipient in $object_utils:ancestors(o)))
    player:tell(o, " is no longer a valid player or maildrop; ignoring that recipient.");
  elseif (o != player)
    recips = setadd(recips, o);
  endif
endfor
subject = msg[4];
if (subject == " ")
  subject = "";
elseif (subject && index(subject, "Re: ") != 1)
  subject = "Re: " + subject;
endif
return {recips, subject};
