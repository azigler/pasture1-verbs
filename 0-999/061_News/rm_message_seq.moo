#61:rm_message_seq   this none this rxd

if (this:ok_write(caller, caller_perms()))
  seq = args[1];
  this.current_news_going = $seq_utils:intersection(this.current_news, seq);
  this.current_news = $seq_utils:contract(this.current_news, seq);
  return $mail_agent:(verb)(@args);
else
  return E_PERM;
endif
