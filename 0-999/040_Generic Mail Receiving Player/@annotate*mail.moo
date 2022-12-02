#40:@annotate*mail   any any any rd

"@annotate <msg-sequence> [on <recipient>] with \"annotation\"";
"prefix the specified messages with the given annotation.";
set_task_perms(player);
if (!(p = this:parse_mailread_cmd("@annotate", args, "cur", "on", 1)))
  "...lose...";
elseif (length(p[4]) != 2 || p[4][1] != "with")
  player:notify(tostr("Usage:  ", verb, " [<message numbers>] [on <folder>] with <annotation>"));
else
  {target, message_sequence, _, trailing_args} = p;
  annotation = trailing_args[2..$];
  annotation[1] = tostr("[", player.name, " (", player, "):  ", annotation[1], "]");
  if (typeof(e = target:annotate_message_seq(annotation, "prepend", message_sequence)) in {ERR, STR})
    player:notify(tostr("Annotation Failed:  ", e));
  else
    count = $seq_utils:size(message_sequence);
    player:notify(tostr("Annotating ", count, " message", count == 1 ? "" | "s", " on ", $mail_agent:name(target), " with:"));
    player:notify_lines(annotation);
  endif
endif
"Copied from annotatetest (#87053):@annotate [verb author Puff (#1449)] at Mon Feb 14 14:45:41 2005 PST";
