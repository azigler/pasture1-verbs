#46:"expunge_rmm list_rmm"   this none this rxd

":list_rmm()    displays contents of .messages_going.";
":expunge_rmm() destroys contents of .messages_going once and for all.";
"... both return the number of messages in .messages_going.";
set_task_perms(caller_perms());
cmg = caller.messages_going;
if (cmg && (!cmg[1] || typeof(cmg[1][2]) == INT))
  kept = cmg[1];
  cmg = cmg[2];
else
  kept = {};
endif
if (verb == "expunge_rmm")
  caller.messages_going = {};
  count = 0;
  for s in (cmg)
    count = count + length(s[2]);
  endfor
  return count;
elseif (!cmg)
  return 0;
else
  msgs = seq = {};
  next = 1;
  for s in (cmg)
    msgs = {@msgs, @s[2]};
    seq = {@seq, next = next + s[1], next = next + length(s[2])};
  endfor
  kept = {@$seq_utils:contract(kept, $seq_utils:complement(seq, 1, $seq_utils:last(seq))), $maxint};
  k = 1;
  mcount = 0;
  for x in (msgs)
    if (kept[k] <= (mcount = mcount + 1))
      k = k + 1;
    endif
    player:tell($string_utils:right(x[1], 4), ":", k % 2 ? "  " | "= ", caller:msg_summary_line(@x[2]));
    if (ticks_left() < 500 || seconds_left() < 2)
      suspend(0);
    endif
  endfor
  if (msgs)
    player:tell("----+");
  endif
  return length(msgs);
endif
