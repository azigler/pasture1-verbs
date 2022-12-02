#31:"@subscribe*-quick @unsubscribed*-quick"   any any any rd

if (caller_perms() != $nothing && caller_perms() != player)
  return E_PERM;
endif
if (!args)
  all_mlists = {@$mail_agent.contents, @this.mail_lists};
  if (length(all_mlists) > 50 && !$command_utils:yes_or_no(tostr("There are ", length(all_mlists), " mailing lists.  Are you sure you want the whole list?")))
    return player:tell("OK, aborting.");
  endif
  for c in (all_mlists)
    $command_utils:suspend_if_needed(0);
    if (c:is_usable_by(this) || c:is_readable_by(this) && verb != "@unsubscribed")
      `c:look_self(1) ! ANY';
    endif
  endfor
  player:tell("--End of List--");
else
  player:tell("Sorry, Guests don't have full mailing privileges.  You may use @read and @peek for mailing lists.  Or try @request to get yourself a character.");
endif
"Paragraph (#122534) - Tue Nov 8, 2005 - Added to prevent a silly traceback from occuring, since Guests can't read their own .current_message.";
