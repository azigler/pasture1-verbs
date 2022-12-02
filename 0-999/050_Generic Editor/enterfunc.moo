#50:enterfunc   this none this rxd

who_obj = args[1];
if (who_obj.wizard && !(who_obj in this.active))
  this:accept(who_obj);
endif
pass(@args);
if (this.invoke_task == task_id())
  "Means we're about to load something, so be quiet.";
  this.invoke_task = 0;
elseif (who = this:loaded(who_obj))
  who_obj:tell("You are working on ", this:working_on(who), ".");
elseif (msg = this:nothing_loaded_msg())
  who_obj:tell(msg);
endif
