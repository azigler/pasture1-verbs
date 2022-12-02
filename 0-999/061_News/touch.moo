#61:touch   this none none rxd

if (!this:ok_write(caller, valid(who = caller_perms()) ? who | player))
  player:notify("Permission denied.");
  return;
endif
fork (0)
  for p in (connected_players())
    $command_utils:suspend_if_needed(0);
    if ((p:get_current_message(this) || {0, 0})[2] < this.last_news_time)
      p:notify("There's a new edition of the newspaper.  Type 'news new' to see the new article(s).");
    endif
  endfor
endfork
