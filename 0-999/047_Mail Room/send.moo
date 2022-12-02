#47:send   none none none rd

"WIZARDLY";
if (!(who = this:loaded(player)))
  player:notify(this:nothing_loaded_msg());
elseif (!(recips = this.recipients[who]))
  player:notify("Umm... your message isn't addressed to anyone.");
elseif (this:sending(who))
  player:notify("Again? ... relax... it'll get there eventually.");
else
  msg = this:message_with_headers(who);
  this.sending[who] = old_sending = task_id();
  this:set_changed(who, 0);
  player:notify("Sending...");
  "... this sucker can suspend BIG TIME...";
  result = $mail_agent:raw_send(msg, recips, player);
  "... the world changes...";
  who = player in this.active;
  if (who && this.sending[who] == old_sending)
    "... same editing session; no problemo...";
    previous = "";
    this.sending[who] = 0;
  else
    "... uh oh, different session... tiptoe quietly out...";
    "... Don't mess with the session.";
    previous = "(prior send) ";
  endif
  if (!(e = result[1]))
    player:notify(tostr(previous, typeof(e) == ERR ? e | "Bogus recipients:  " + $string_utils:from_list(result[2])));
    player:notify(tostr(previous, "Mail not sent."));
    previous || this:set_changed(who, 1);
  elseif (length(result) == 1)
    player:notify(tostr(previous, "Mail not actually sent to anyone."));
    previous || this:set_changed(who, 1);
  else
    player:notify(tostr(previous, "Mail actually sent to ", $mail_agent:name_list(@listdelete(result, 1))));
    if (previous)
      "...don't even think about it...";
    elseif (player.location == this)
      if (ticks_left() < 10000)
        suspend(0);
      endif
      this:done();
    elseif (!this:changed(who))
      "... player is gone, no further edits...";
      this:kill_session(who);
    endif
  endif
endif
