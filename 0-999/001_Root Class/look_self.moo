#1:look_self   this none this rxd

desc = this:description();
if (desc)
  player:tell_lines(desc);
else
  player:tell("You see nothing special.");
endif
