#40:"@rn check_mail_lists @subscribed @rn-full"   none none none rxd

set_task_perms(caller == this ? this.owner | caller_perms());
which = {};
cm = this.current_message;
cm[1..2] = verb == "@rn" || verb == "@rn-full" ? {{this, @cm[1..2]}} | {};
all = verb == "@subscribed";
fast = this:mail_option("fast_check") && verb != "@rn-full";
for n in (cm)
  rcpt = n[1];
  if (rcpt == $news)
    "... $news is handled separately ...";
  elseif ($mail_agent:is_recipient(rcpt))
    if (fast)
      if (rcpt == this)
        nmsgs = (m = this.messages) && m[length(m)][2][1] > n[3] ? $maxint | 0;
      else
        try
          nmsgs = n[1].last_msg_date > n[3] ? $maxint | 0;
        except (E_PERM, E_PROPNF)
          player:notify(tostr("Bogus recipient ", rcpt, " removed from .current_message."));
          this.current_message = setremove(this.current_message, n);
          nmsgs = 0;
        endtry
      endif
    else
      nmsgs = n[1]:length_date_gt(n[3]);
    endif
    if (nmsgs || all)
      which = {@which, {n[1], nmsgs}};
    endif
  else
    player:notify(tostr("Bogus recipient ", rcpt, " removed from .current_message."));
    this.current_message = setremove(this.current_message, n);
  endif
  $command_utils:suspend_if_needed(0);
endfor
if (which)
  player:notify(tostr(verb == "@subscribed" ? "You are subscribed to the following" | "There is new activity on the following", length(which) > 1 ? " lists:" | " list:"));
  for w in (which)
    name = w[1] == this ? " me" | $mail_agent:name(w[1]);
    player:notify(tostr($string_utils:left("    " + name, 40), " ", w[2] == $maxint ? "has" | w[2], " new message", w[2] == 1 ? "" | "s"));
    $command_utils:suspend_if_needed(0);
  endfor
  if (verb != "check_mail_lists")
    player:notify("-- End of listing");
  endif
elseif (verb == "@rn" || verb == "@rn-full")
  player:notify("No new activity on any of your lists.");
elseif (verb == "@subscribed")
  player:notify("You aren't subscribed to any mailing lists.");
endif
return which;
