#48:w*hat   none none none rd

pass(@args);
if ((who = this:loaded(player)) && this.strmode[who])
  player:tell("Text will be stored as a single string instead of a list when possible.");
endif
