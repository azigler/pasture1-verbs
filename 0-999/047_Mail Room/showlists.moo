#47:showlists   any none none rd

player:tell_lines({"Available aliases:", ""});
for c in (dobjstr == "all" ? $object_utils:descendants($mail_recipient) | $mail_agent.contents)
  if (c:is_usable_by(player) || c:is_readable_by(player))
    c:look_self();
  endif
endfor
