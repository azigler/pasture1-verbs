#61:@clearnews   this none none rd

set_task_perms(player);
if (this:is_writable_by(player))
  this:set_current_news({});
  player:notify("Current newspaper is now empty.");
else
  player:notify("You can't write the news.");
endif
