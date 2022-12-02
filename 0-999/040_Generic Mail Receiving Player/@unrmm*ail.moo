#40:@unrmm*ail   any any any rd

"@unrmm [on <recipient>]  -- undoes the previous @rmm on that recipient.";
set_task_perms(player);
if (!(p = this:parse_folder_spec("@unrmm", args, "on")))
  return;
endif
dobjstr = $string_utils:from_list(p[2], " ");
keep = 0;
if (!dobjstr || (keep = index("keep", dobjstr) == 1))
  do = "undo_rmm";
elseif (index("expunge", dobjstr) == 1)
  do = "expunge_rmm";
elseif (index("list", dobjstr) == 1)
  do = "list_rmm";
else
  player:notify(tostr("Usage:  ", verb, " [expunge|list] [on <recipient>]"));
  return;
endif
this:set_current_folder(folder = p[1]);
if (msg_seq = folder:(do)(@keep ? {keep} | {}))
  if (do == "undo_rmm")
    player:notify(tostr($seq_utils:size(msg_seq), " messages restored to ", $mail_agent:name(folder), "."));
    folder:display_seq_headers(msg_seq, 0);
  else
    player:notify(tostr(msg_seq, " zombie message", msg_seq == 1 ? " " | "s ", do == "expunge_rmm" ? "expunged from " | "on ", $mail_agent:name(folder), "."));
  endif
elseif (typeof(msg_seq) == ERR)
  player:notify(tostr($mail_agent:name(folder), ":  ", msg_seq));
else
  player:notify(tostr("No messages to ", do == "expunge_rmm" ? "expunge from " | "restore to ", $mail_agent:name(folder)));
endif
