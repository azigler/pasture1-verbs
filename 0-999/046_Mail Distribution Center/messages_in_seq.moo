#46:messages_in_seq   this none this rxd

":messages_in_seq(msg_seq) => list of messages in msg_seq on folder (caller)";
set_task_perms(caller_perms());
if (typeof(msgs = args[1]) != LIST)
  return caller.messages[msgs];
elseif (length(msgs) == 2)
  return caller.messages[msgs[1]..msgs[2] - 1];
else
  return $seq_utils:extract(msgs, caller.messages);
endif
