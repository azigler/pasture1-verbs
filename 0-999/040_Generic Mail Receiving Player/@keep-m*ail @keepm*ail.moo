#40:"@keep-m*ail @keepm*ail"   any any any rd

"@keep-mail [<msg-sequence>|none] [on <recipient>]";
"marks the indicated messages as `kept'.";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
if (!args)
  return player:notify("Usage:  @keep-mail [<msg-sequence>|none] [on <recipient>]");
elseif (args[1] == "none")
  args[1..1] = {};
  if (!(pfs = this:parse_folder_spec(verb, args, "on", 0)))
    return;
  elseif (pfs[2])
    player:notify(tostr(verb, " <message-sequence> or `none', but not both."));
    return;
  endif
  this:set_current_folder(folder = pfs[1]);
  if (e = folder:keep_message_seq({}))
    player:notify(tostr("Messages on ", $mail_agent:name(folder), " are no longer marked as kept."));
  else
    player:notify(tostr(e));
  endif
  return;
elseif (p = this:parse_mailread_cmd(verb, args, "", "on"))
  if ((folder = p[1]) != this)
    "... maybe I'll take this clause out some day...";
    player:notify(tostr(verb, " can only be used on your own mail collection."));
    return;
  endif
  this:set_current_folder(folder);
  if (e = folder:keep_message_seq(msg_seq = p[2]))
    player:notify(tostr("Message", match(e, "[.,]") ? "s " | " ", e, " now marked as kept."));
  elseif (typeof(e) == ERR)
    player:notify(tostr(e));
  else
    player:notify(tostr((seq_size = $seq_utils:size(msg_seq)) == 1 ? "That message is" | "Those messages are", " already marked as kept."));
  endif
endif
