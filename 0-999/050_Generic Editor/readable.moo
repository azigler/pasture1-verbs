#50:readable   this none this rxd

return (who = args[1]) < 1 || who > length(this.active) ? E_RANGE | this.readable[who];
