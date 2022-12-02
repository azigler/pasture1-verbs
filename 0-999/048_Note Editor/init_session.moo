#48:init_session   this none this rxd

if (this:ok(who = args[1]))
  this.strmode[who] = strmode = typeof(text = args[3]) == STR;
  this:load(who, strmode ? text ? {text} | {} | text);
  this.objects[who] = args[2];
  player:tell("Now editing ", this:working_on(who), ".", strmode ? "  [string mode]" | "");
endif
