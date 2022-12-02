#40:expire_old_messages   this none this rxd

set_task_perms(caller_perms());
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
else
  seq = this:expirable_msg_seq();
  if (seq)
    this:rm_message_seq(seq);
    return this:expunge_rmm();
  else
    return 0;
  endif
endif
