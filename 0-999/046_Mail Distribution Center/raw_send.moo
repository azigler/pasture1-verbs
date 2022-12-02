#46:raw_send   this none this rxd

"Copied from Mail Distribution Center (#6418):raw_send by Nosredna (#2487) Mon Feb 24 10:46:26 1997 PST";
"WIZARDLY";
"raw_send(text,rcpts,sender) -- does the actual sending of a message.  Assumes that text has already been formatted correctly.  Decides who to send it to and who wants to be notified about it and does so.";
"Return {E_PERM} if the caller is not entitled to use this verb.";
"Return {0, @invalid_rcpts} if rcpts contains any invalid addresses.  No mail is sent in this case.";
"Return {1, @actual_rcpts} if successful.";
{text, rcpts, from} = args;
if (typeof(rcpts) != LIST)
  rcpts = {rcpts};
endif
if (!(caller in {$mail_agent, $mail_editor}))
  return {E_PERM};
elseif (bogus = (resolve = this:resolve_addr(rcpts, from))[1])
  return {0, bogus};
else
  set_task_perms($wiz_utils:random_wizard());
  this:touch(rcpts);
  actual_rcpts = resolve[2];
  biffs = resolve[3];
  results = {};
  for recip in (actual_rcpts)
    if (ticks_left() < 10000 || seconds_left() < 2)
      player:notify(tostr("...", recip));
      suspend(1);
    endif
    if (typeof(e = recip:receive_message(text, from)) in {ERR, STR})
      "...receive_message bombed...";
      player:notify(tostr(recip, ":receive_message:  ", e));
      e = 0;
    elseif (!is_player(recip) || !e)
      "...not a player or receive_message isn't giving out the message number";
      "...no need to force a notification...";
    elseif (i = $list_utils:iassoc(recip, biffs))
      "...player-recipient was already getting a notification...";
      "...make sure notification includes a mention of him/her/itself.";
      if (!(recip in listdelete(biffs[i], 1)))
        biffs[i][2..1] = {recip};
      endif
    else
      "...player-recipient wasn't originally being notified at all...";
      biffs = {{recip, recip}, @biffs};
    endif
    results = {@results, e};
  endfor
  "The following is because the scheduler can BITE ME. --Nosredna";
  fork (0)
    for b in (biffs)
      if (ticks_left() < 10000 || seconds_left() < 2)
        suspend(1);
      endif
      if ($object_utils:has_callable_verb(b[1], "notify_mail"))
        mnums = {};
        for r in (listdelete(b, 1))
          mnums = {@mnums, (rn = r in actual_rcpts) && results[rn]};
        endfor
        b[1]:notify_mail(from, listdelete(b, 1), mnums);
      endif
    endfor
  endfork
  return {1, @actual_rcpts};
endif
