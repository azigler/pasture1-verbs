#50:y*ank   any any any rd

"Usage: yank from <note>";
"       yank <message-sequence> from <mail-recipient>";
"       yank from <object>:<verb>";
"       yank from <object>.<property>";
"Grabs the specified text and inserts it at the cursor.";
set_task_perms(player);
if (dobjstr)
  "yank <message-sequence> from <mail-recipient>";
  if (!(p = player:parse_mailread_cmd(verb, args, "", "from")))
    return;
  elseif ($seq_utils:size(sequence = p[2]) != 1)
    player:notify(tostr("You can only ", verb, " one message at a time"));
    return;
  else
    m = (folder = p[1]):messages_in_seq(sequence);
    msg = m[1];
    header = tostr("Message ", msg[1]);
    if (folder != player)
      header = tostr(header, " on ", $mail_agent:name(folder));
    endif
    header = tostr(header, ":");
    lines = {header, @player:msg_full_text(@msg[2])};
    this:insert_line(this:loaded(player), lines, 0);
  endif
elseif (pr = $code_utils:parse_propref(iobjstr))
  o = player:my_match_object(pr[1]);
  if ($command_utils:object_match_failed(o, pr[1]))
    return;
  elseif ((lines = `o.(pr[2]) ! ANY') == E_PROPNF)
    player:notify(tostr("There is no `", pr[2], "' property on ", $string_utils:nn(o), "."));
    return;
  elseif (lines == E_PERM)
    player:notify(tostr("Error: Permission denied reading ", iobjstr));
    return;
  elseif (typeof(lines) == ERR)
    player:notify(tostr("Error: ", lines, " reading ", iobjstr));
    return;
  elseif (typeof(lines) == STR)
    this:insert_line(this:loaded(player), lines, 0);
    return;
  elseif (typeof(lines) == LIST)
    for x in (lines)
      if (typeof(x) != STR)
        player:notify(tostr("Error: ", iobjstr, " does not contain a ", verb, "-able value."));
        return;
      endif
    endfor
    this:insert_line(this:loaded(player), lines, 0);
    return;
  else
    player:notify(tostr("Error: ", iobjstr, " does not contain a ", verb, "-able value."));
    return;
  endif
elseif (pr = $code_utils:parse_verbref(iobjstr))
  o = player:my_match_object(pr[1]);
  if ($command_utils:object_match_failed(o, pr[1]))
    return;
  elseif (lines = `verb_code(o, pr[2], !player:edit_option("no_parens")) ! ANY')
    this:insert_line(this:loaded(player), lines, 0);
    return;
  elseif (lines == E_PERM)
    player:notify(tostr("Error: Permission denied reading ", iobjstr));
    return;
  elseif (lines == E_VERBNF)
    player:notify(tostr("There is no `", pr[2], "' verb on ", $string_utils:nn(o), "."));
  else
    player:notify(tostr("Error: ", lines, " reading ", iobjstr));
    return;
  endif
elseif ($command_utils:object_match_failed(iobj = player:my_match_object(iobjstr), iobjstr))
  return;
elseif ((lines = `iobj:text() ! ANY') == E_PERM)
  player:notify(tostr("Error: Permission denied reading ", iobjstr));
  return;
elseif (lines == E_VERBNF)
  player:notify(tostr($string_utils:nn(iobj), " doesn't seem to be a note."));
elseif (typeof(lines) == ERR)
  player:notify(tostr("Error: ", lines, " reading ", iobjstr));
  return;
else
  this:insert_line(this:loaded(player), lines, 0);
endif
