#50:set_readable   this none this rxd

return this:ok(who = args[1]) && (this.readable[who] = !!args[2]);
