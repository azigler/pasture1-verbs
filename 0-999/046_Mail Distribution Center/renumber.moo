#46:renumber   this none this rxd

":renumber([cur]) -- assumes caller is a $mail_recipient or a $player.";
"...renumbers caller.messages, doing a suspend() if necessary.";
"...returns {number of messages,new cur}.";
set_task_perms(caller_perms());
{?cur = 0} = args;
caller.messages_going = {};
"... blow away @rmm'ed messages since there's no way to tell what their new numbers should be...";
msgs = caller.messages;
if (cur)
  cur = $list_utils:iassoc_sorted(cur, msgs);
endif
while (1)
  "...find first out-of-sequence message...";
  l = 0;
  r = (len = length(msgs)) + 1;
  while (r - 1 > l)
    if (msgs[i = (r + l) / 2][1] > i)
      r = i;
    else
      l = i;
    endif
  endwhile
  "... r == first out-of-sequence, l == last in-sequence, l+1 == r ...";
  if (l >= len)
    return {l, cur};
  endif
  "...renumber as many messages as we have time for...";
  chunk = {};
  while (r <= len && ticks_left() > 3000 && seconds_left() > 2)
    for x in (msgs[r..min(r + 9, len)])
      chunk = {@chunk, {r, x[2]}};
      r = r + 1;
    endfor
  endwhile
  caller.messages = {@msgs[1..l], @chunk, @msgs[r..len]};
  if (chunk)
    player:tell("...(renumbering ", l + 1, " -- ", r - 1, ")");
    suspend(0);
  else
    player:tell("You lose.  This message collection is just too big.");
    return;
  endif
  "... have to be careful since new mail may be received at this point...";
  msgs = caller.messages;
endwhile
