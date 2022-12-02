#46:subject_msg_seq   this none this rxd

":subject_msg_seq(target) => msg_seq of messages with target in the Subject:";
set_task_perms(caller_perms());
{target, ?mask = {1}} = args;
i = 1;
seq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    subject = msg[2][4];
    if (index(subject, target))
      seq = $seq_utils:add(seq, i, i);
    endif
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return seq || "%f %<has> no messages with subjects containing `" + target + "'";
