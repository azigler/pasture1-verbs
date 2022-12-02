#99:add_noansi   this none this rxd

":add_noansi()";
"Called by tasks to tell players to ignore any ANSI codes from them.";
"Can be undone with a call to :remove_noansi";
if (length(this.noansi_queue) > 30 && !$code_utils:task_valid(this.noansi_task))
  fork tid (0)
    this:cleanup_noansi();
  endfork
  this.noansi_task = tid;
endif
this.noansi_queue = setadd(this.noansi_queue, task_id());
