#57:@log   any any any rd

"@log [<string>]    enters a comment in the server log.";
"If no string is given, you are prompted to enter one or more lines for an extended comment.";
set_task_perms(player);
whostr = tostr("from ", player.name, " (", player, ")");
if (!player.wizard || player != caller)
  player:notify("Yeah, right.");
elseif (argstr)
  server_log(tostr("COMMENT: [", whostr, "]  ", argstr));
  player:notify("One-line comment logged.");
elseif (lines = $command_utils:read_lines())
  server_log(tostr("COMMENT: [", whostr, "]"));
  for l in (lines)
    server_log(l);
  endfor
  server_log(tostr("END_COMMENT."));
  player:notify(tostr(length(lines), " lines logged as extended comment."));
endif
