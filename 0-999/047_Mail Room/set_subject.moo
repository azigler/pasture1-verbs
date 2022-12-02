#47:set_subject   this none this rxd

if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
else
  this.subjects[who] = subj = args[2];
  this:set_changed(who, 1);
  return subj;
endif
