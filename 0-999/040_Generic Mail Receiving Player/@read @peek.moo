#40:"@read @peek"   any any any rxd

"@read <msg>...                  -- as in help @read";
"@read <msg>... on *<recipient>  -- reads messages on recipient.";
"@peek ...                       -- like @read, but don't set current message";
set_task_perms(valid(cp = caller_perms()) ? cp | player);
if (p = this:parse_mailread_cmd("@read", args, "", "on"))
  this:set_current_folder(folder = p[1]);
  msg_seq = p[2];
  if ((lim = player:mail_option("manymsgs")) && (lim <= (seq_size = $seq_utils:size(msg_seq)) && !$command_utils:yes_or_no(tostr("You are about to see ", seq_size, " messages.  Continue?"))))
    player:notify(tostr("Aborted.  @mailoption manymsgs=", lim));
    return;
  endif
  this._mail_task = task_id();
  if (cur = folder:display_seq_full(msg_seq, tostr("Message %d", folder == this ? "" | " on " + $mail_agent:name(folder), ":")))
    if (verb != "@peek")
      this:set_current_message(folder, @cur);
    endif
  endif
endif
