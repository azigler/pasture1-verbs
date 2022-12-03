#166:read   this none none rxd

pass(@args);
if (length(this.completed))
  player:tell();
  player:tell("This checklist has completed items:");
  player:tell();
  player:tell_lines_suspended(this:_get_completed_items());
  player:tell();
endif
