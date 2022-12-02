#61:set_current_news   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
else
  this.current_news = new = args[1];
  if (new)
    newlast = $seq_utils:last(new);
    newlasttime = this:messages_in_seq(newlast)[2][1];
    if (newlasttime > this.last_news_time)
      "... only notify people if there exists a genuinely new item...";
      this.last_news_time = newlasttime;
      this:touch();
    endif
  else
    "...flush everything...";
    this.last_news_time = 0;
  endif
endif
