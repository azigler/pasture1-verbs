#40:@skip   any any any rd

"@skip [*<folder/mailing_list>...]";
"  sets your last-read time for the given lists to now, indicating your";
"  disinterest in any new messages that might have appeared recently.";
set_task_perms(player);
current_folder = this:current_folder();
for a in (args || {0})
  if (a ? $mail_agent:match_failed(folder = $mail_agent:match_recipient(a), a) | (folder = this:current_folder()))
    "...bogus folder name, done...  No, try anyway.";
    if (this:kill_current_message(this:my_match_object(a)))
      player:notify("Invalid folder, but found it subscribed anyway.  Removed.");
    endif
  else
    lseq = folder:length_all_msgs();
    unread = (n = this:get_current_message(folder)) ? folder:length_date_gt(n[2]) | lseq;
    this:set_current_message(folder, lseq && folder:messages_in_seq({lseq, lseq + 1})[1][1], time());
    player:notify(tostr(unread ? tostr("Ignoring ", unread) | "No", " unread message", unread != 1 ? "s" | "", " on ", $mail_agent:name(folder)));
    if (current_folder == folder)
      this:set_current_folder(this);
    endif
  endif
endfor
