#50:enter   any none none rd

if (!this:loaded(player))
  player:tell(this:nothing_loaded_msg());
else
  lines = $command_utils:read_lines();
  if (typeof(lines) == ERR)
    player:notify(tostr(lines));
    return;
  endif
  this:insert_line(this:loaded(player), lines, 0);
endif
