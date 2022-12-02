#40:"@refile @copym*ail"   any any any rd

"@refile/@copym*ail <msg-sequence> [on <recipient>] to <recipient>";
"@refile will delete the messages from the source folder.  @copym does not.";
"I'm not happy with this one, yet...";
set_task_perms(player);
if (!(p = this:parse_mailread_cmd("@refile", args, "cur", "on", 1)))
  "...lose...";
elseif (length(p[4]) != 2 || p[4][1] != "to")
  player:notify(tostr("Usage:  ", verb, " [<message numbers>] [on <folder>] to <folder>"));
elseif ($mail_agent:match_failed(dest = $mail_agent:match_recipient(p[4][2]), p[4][2]))
  "...bogus destination folder...";
else
  source = p[1];
  msg_seq = p[2];
  for m in (source:messages_in_seq(msg_seq))
    if (!(e = dest:receive_message(m[2], source)))
      player:notify(tostr("Copying msg. ", m[1], ":  ", e));
      return;
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  if (refile = verb == "@refile")
    if (typeof(e = source:rm_message_seq(msg_seq)) == ERR)
      player:notify(tostr("Deleting from ", source, ":  ", e));
    endif
  endif
  count = tostr(n = $seq_utils:size(msg_seq), " message", n == 1 ? "" | "s");
  fname = source == this ? "" | tostr(is_player(source) ? " from " | " from *", source.name, "(", source, ")");
  suffix = tostr(is_player(dest) ? " to " | " to *", dest.name, "(", dest, ").");
  player:notify(tostr(refile ? "Refiled " | "Copied ", count, fname, suffix));
endif
