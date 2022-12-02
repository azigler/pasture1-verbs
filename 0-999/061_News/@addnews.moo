#61:@addnews   any (at/to) this rxd

if (caller_perms() != #-1 && caller_perms() != player)
  raise(E_PERM);
endif
set_task_perms(player);
if (!this:is_writable_by(player))
  player:notify("You can't write the news.");
elseif (typeof(result = this:add_news(args[1..(prepstr in args) - 1], player:get_current_message(this) || {0, 0})) == STR)
  player:notify(result);
else
  new = this.current_news;
  if (new)
    player:notify("Current newspaper set.");
    this:display_seq_headers(new);
  else
    player:notify("Current newspaper is now empty.");
  endif
endif
