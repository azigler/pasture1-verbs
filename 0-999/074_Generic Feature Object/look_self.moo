#74:look_self   this none this rxd

"Definition from #1";
desc = this:description();
if (desc)
  player:tell_lines(desc);
else
  player:tell("You see nothing special.");
endif
player:tell("Please type \"help ", this, "\" for more information.");
