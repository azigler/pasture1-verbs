#95:init_session   this none this rxd

if (this:ok(who = args[1]))
  this:load(who, args[4]);
  this.objects[who] = args[2];
  this.properties[who] = args[3];
  player:tell("Now editing ", this:working_on(who), ".");
endif
