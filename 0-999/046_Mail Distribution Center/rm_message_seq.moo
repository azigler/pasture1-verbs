#46:rm_message_seq   this none this rxd

":rm_message_seq(msg_seq)  removes the given sequence of from folder (caller)";
"...removed messages are saved in .messages_going for possible restoration.";
set_task_perms(caller_perms());
old = caller.messages;
new = save = nums = {};
next = 1;
for i in [1..length(seq = args[1]) / 2]
  if ($command_utils:running_out_of_time())
    player:tell("... rmm ", old[next][1] - 1);
    suspend(0);
  endif
  start = seq[2 * i - 1];
  new = {@new, @old[next..start - 1]};
  save = {@save, {start - next, old[start..(next = seq[2 * i]) - 1]}};
  nums = {@nums, old[start][1], old[next - 1][1] + 1};
endfor
new = {@new, @old[next..$]};
$command_utils:suspend_if_needed(0, "... rmm ...");
save_kept = $seq_utils:intersection(caller.messages_kept, seq);
$command_utils:suspend_if_needed(0, "... rmm ...");
new_kept = $seq_utils:contract(caller.messages_kept, seq);
$command_utils:suspend_if_needed(0, "... rmm ...");
caller.messages_going = save_kept ? {save_kept, save} | save;
caller.messages = new;
caller.messages_kept = new_kept;
if ($object_utils:has_callable_verb(caller, "_fix_last_msg_date"))
  caller:_fix_last_msg_date();
endif
return $seq_utils:tostr(nums);
