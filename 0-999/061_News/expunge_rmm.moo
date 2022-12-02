#61:expunge_rmm   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
this.current_news_going = {};
return $mail_agent:(verb)(@args);
