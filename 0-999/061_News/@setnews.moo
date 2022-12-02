#61:@setnews   this (at/to) any rd

set_task_perms(player);
if (!this:is_writable_by(player))
  player:notify("You can't write the news.");
elseif (typeof(seq = this:_parse(strings = args[(prepstr in args) + 1..$], @player:get_current_message(this) || {0, 0})) == STR)
  player:notify(seq);
else
  old = this.current_news;
  if (old == seq)
    player:notify("No change.");
  else
    this:set_current_news(seq);
    if (seq)
      player:notify("Current newspaper set.");
      this:display_seq_headers(seq);
    else
      player:notify("Current newspaper is now empty.");
    endif
  endif
endif
