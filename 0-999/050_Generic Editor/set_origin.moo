#50:set_origin   this none this rxd

return this:ok(who = args[1]) && (valid(origin = args[2]) && origin != this || (origin == $nothing || E_INVARG) && (this.original[who] = origin));
