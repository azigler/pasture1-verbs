#14:subject_msg_seq   this none this rxd

":subject_msg_seq(target) => msg_seq of messages with target in the Subject:";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (!this.messages)
  return {};
endif
{target, ?mask = {1, this.messages[2] + 1}} = args;
seq = {};
for m in [1..length(mask) / 2]
  handle = this._mgr:start(this.messages, i = mask[2 * m - 1], mask[2 * m] - 1);
  while (handle)
    for msg in (handle[1])
      if ((subject = msg[6]) != " " && index(subject, target))
        seq = $seq_utils:add(seq, i, i);
      endif
      i = i + 1;
      $command_utils:suspend_if_needed(0);
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
endfor
return seq || "%f %<has> no messages with subjects containing `" + target + "'";
