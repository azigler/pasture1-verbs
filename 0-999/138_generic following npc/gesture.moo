#138:gesture   this none none rxd

if (this.location == player)
  return player:tell("Might want to let it down.");
endif
$you:say_action(this.gesture_msg, player, this);
if (this.owner != player)
  $you:say_action("%N ignores %t.", this, player);
else
  this:follow(this.following != 0 ? this | player);
endif
