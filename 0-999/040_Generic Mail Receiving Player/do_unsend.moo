#40:do_unsend   this none this rxd

":do_unsend(seq) -> Remove the specified messages. Used by @unsend. Cannot be overridden by players or player classes; @unsend won't bother to call the verb.";
if (!caller_perms().wizard)
  return E_PERM;
endif
return $mail_agent:rm_message_seq(@args);
