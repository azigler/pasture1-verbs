#40:@renumber   any none none rd

set_task_perms(player);
if (!dobjstr)
  folder = this:current_folder();
elseif ($mail_agent:match_failed(folder = $mail_agent:match_recipient(dobjstr), dobjstr))
  return;
endif
cur = this:current_message(folder);
fname = $mail_agent:name(folder);
if (typeof(h = folder:renumber(cur)) == ERR)
  player:notify(tostr(h));
else
  if (!h[1])
    player:notify(tostr("No messages on ", fname, "."));
  else
    player:notify(tostr("Messages on ", fname, " renumbered 1-", h[1], "."));
    this:set_current_folder(folder);
    if (h[2] && this:set_current_message(folder, h[2]))
      player:notify(tostr("Current message is now ", h[2], "."));
    endif
  endif
endif
