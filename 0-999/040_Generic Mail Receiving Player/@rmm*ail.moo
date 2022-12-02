#40:@rmm*ail   any any any rd

"@rmm <message-sequence> [from <recipient>].   Use @unrmm if you screw up.";
" Beware, though.  @unrmm can only undo the most recent @rmm.";
set_task_perms(player);
if (!(p = this:parse_mailread_cmd("@rmm", args, "cur", "from")))
  "...parse failed, we've already complained...";
elseif (!prepstr && (p[1] != this && !$command_utils:yes_or_no("@rmmail from " + $mail_agent:name(p[1]) + ".  Continue?")))
  "...wasn't the folder player was expecting...";
  player:notify("@rmmail aborted.");
else
  this:set_current_folder(folder = p[1]);
  e = folder:rm_message_seq(p[2]);
  if (typeof(e) == ERR)
    player:notify(tostr($mail_agent:name(folder), ":  ", e));
  else
    count = (n = $seq_utils:size(p[2])) == 1 ? "." | tostr(" (", n, " messages).");
    fname = folder == this ? "" | " from " + $mail_agent:name(folder);
    player:notify(tostr("Deleted ", e, fname, count));
  endif
endif
