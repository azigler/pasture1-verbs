#6:"i inv*entory"   none none none rd

if (c = player:contents())
  this:tell_contents(c);
else
  player:tell("You are empty-handed.");
endif
