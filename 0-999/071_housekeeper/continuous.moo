#71:continuous   this none this rxd

"start the housekeeper cleaning continuously. Kill any previous continuous";
"task. Not meant to be called interactively.";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
if ($code_utils:task_valid(this.task))
  taskn = this.task;
  this.task = 0;
  kill_task(taskn);
endif
fork taskn (0)
  while (1)
    index = 1;
    while (index <= length(this.clean))
      this.cleaning = x = this.clean[index];
      this.cleaning_index = index;
      index = index + 1;
      fork (0)
        `this:replace(x) ! ANY';
      endfork
      suspend(this.testing ? 2 | this:time());
    endwhile
    suspend(5);
    this:litterbug();
  endwhile
endfork
this.task = taskn;
