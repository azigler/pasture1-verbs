#99:cleanup_noansi   this none this rxd

while (this.noansi_queue && !$command_utils:running_out_of_time())
  x = this.noansi_queue[1];
  if (!$code_utils:task_valid(x))
    this.noansi_queue = setremove(this.noansi_queue, x);
  endif
endwhile
