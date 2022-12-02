#50:kill_session   this none this rxd

"WIZARDLY";
if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
else
  for p in ({@this.stateprops, {"original"}, {"active"}, {"times"}})
    this.(p[1]) = listdelete(this.(p[1]), who);
  endfor
  return who;
endif
