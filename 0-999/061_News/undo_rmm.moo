#61:undo_rmm   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
seq = $mail_agent:(verb)(@args);
this.current_news = $seq_utils:union(this.current_news_going, $seq_utils:expand(this.current_news, seq));
this.current_news_going = {};
return seq;
