#88:receive_message   this none this rxd

"'receive_message (<message>, <sender>)' - Receive the given mail message from the given sender. This version handles refusal of the message.";
if (!$perm_utils:controls(caller_perms(), this) && caller != this)
  return E_PERM;
elseif (this:refuses_action(args[2], "mail"))
  return this:mail_refused_msg();
else
  return pass(@args);
endif
