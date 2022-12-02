#46:keep_message_seq   this none this rxd

":keep_message_seq(msg_seq)";
"...If msg_seq nonempty {}, this marks the indicated messages on this folder (caller)";
"...as immune from expiration.";
"...If msg_seq == {}, this clears all such marks.";
set_task_perms(caller_perms());
msg_seq = args[1];
if (!msg_seq)
  caller.messages_kept = {};
  return 1;
endif
prev_kept = caller.messages_kept;
caller.messages_kept = new_kept = $seq_utils:union(prev_kept, msg_seq);
added = $seq_utils:intersection(new_kept, $seq_utils:complement(prev_kept));
if (!added)
  return "";
endif
"... urk.  now we need to get the actual numbers of the messages being kept.";
nums = {};
start = 0;
for a in (added)
  nums = {@nums, (start = !start) ? caller:messages_in_seq(a)[1] | caller:messages_in_seq(a - 1)[1] + 1};
endfor
return $seq_utils:tostr(nums);
