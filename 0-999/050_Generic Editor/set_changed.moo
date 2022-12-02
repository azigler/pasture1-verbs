#50:set_changed   this none this rxd

return this:ok(who = args[1]) && ((unchanged = !args[2]) || (this.times[who] = time()) && (this.changes[who] = !unchanged));
