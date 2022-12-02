#50:reset_session   this none this rxd

"WIZARDLY";
if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
else
  for p in (this.stateprops)
    this.(p[1])[who] = p[2];
  endfor
  this.times[who] = time();
  return who;
endif
