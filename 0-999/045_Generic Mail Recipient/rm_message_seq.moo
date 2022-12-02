#45:rm_message_seq   this none this rxd

":rm_message_seq(msg_seq) removes the given sequence of from folder";
"               => string giving msg numbers removed";
"See the corresponding routine on $mail_agent.";
if (this:ok_write(caller, caller_perms()))
  return $mail_agent:(verb)(@args);
elseif (this:ok(caller, caller_perms()) && (seq = this:own_messages_filter(caller_perms(), @args)))
  return $mail_agent:(verb)(@listset(args, seq, 1));
else
  return E_PERM;
endif
