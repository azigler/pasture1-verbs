#6:home   none none none rd

start = this.location;
if (start == this.home)
  player:tell("You're already home!");
  return;
elseif (typeof(this.home) != OBJ)
  player:tell("You've got a weird home, pal.  I've reset it to the default one.");
  this.home = $player_start;
elseif (!valid(this.home))
  player:tell("Oh no!  Your home's been recycled.  Time to look around for a new one.");
  this.home = $player_start;
else
  player:tell("You click your heels three times.");
endif
this:moveto(this.home);
if (!valid(start))
elseif (start == this.location)
  start:announce(player.name, " ", $gender_utils:get_conj("learns", player), " that you can never go home...");
else
  try
    start:announce(player.name, " ", $gender_utils:get_conj("goes", player), " home.");
  except e (E_VERBNF)
    "start did not support announce";
  endtry
endif
if (this.location == this.home)
  this.location:announce(player.name, " ", $gender_utils:get_conj("comes", player), " home.");
elseif (this.location == start)
  player:tell("Either home doesn't want you, or you don't really want to go.");
else
  player:tell("Wait a minute!  This isn't your home...");
  if (valid(this.location))
    this.location:announce(player.name, " ", $gender_utils:get_conj("arrives", player), ", looking quite bewildered.");
  endif
endif
