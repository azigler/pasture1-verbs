#9:r*ead   this none none rxd

if (!this:is_readable_by(valid(caller_perms()) ? caller_perms() | player))
  player:tell("Sorry, but it seems to be written in some code that you can't read.");
else
  this:look_self();
  player:tell();
  player:tell_lines_suspended(this:text());
  player:tell();
  player:tell("(You finish reading.)");
endif
