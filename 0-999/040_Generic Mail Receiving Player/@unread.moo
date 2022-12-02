#40:@unread   any any any rd

"@unread <msg> [on *<recipient>]  -- resets last-read-date for recipient to just before the first of the indicated messages.";
set_task_perms(player);
if (p = this:parse_mailread_cmd("@unread", args, "cur", "on"))
  this:set_current_folder(folder = p[1]);
  msg_ord = $seq_utils:first(msg_seq = p[2]);
  msgdate = folder:messages_in_seq(msg_ord)[2][1] - 1;
  if (!(cm = this:get_current_message(folder)) || cm[2] < msgdate)
    player:notify("Already unread.");
  else
    if (folder == this)
      this.current_message[2] = msgdate - 1;
    else
      "this:kill_current_message(folder);";
      this:set_current_message(folder, cm[1], min(cm[2], msgdate), 1);
    endif
    folder:display_seq_headers({msg_ord, msg_ord + 1}, cm[1], msgdate);
  endif
endif
