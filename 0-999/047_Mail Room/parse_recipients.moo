#47:parse_recipients   this none this rxd

"parse_recipients(prev_list,list_of_strings) -- parses list of strings and adds any resulting player objects to prev_list.  Optional 3rd arg is prefixed to any mismatch error messages";
{recips, l, ?cmd_id = ""} = args;
cmd_id = cmd_id || "";
for s in (typeof(l) == LIST ? l | {l})
  if (typeof(s) != STR)
    if ($mail_agent:is_recipient(s))
      recips = setadd(recips, s);
    else
      player:tell(cmd_id, s, " is not a valid mail recipient.");
    endif
  elseif (!$mail_agent:match_failed(md = $mail_agent:match_recipient(s), s, cmd_id))
    recips = setadd(recips, md);
  endif
endfor
return recips;
