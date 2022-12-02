#47:sending   this none this rxd

if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
elseif (!(task = this.sending[who]) || $code_utils:task_valid(task))
  return task;
else
  "... uh oh... sending task crashed...";
  this:set_changed(who, 1);
  return this.sending[who] = 0;
endif
