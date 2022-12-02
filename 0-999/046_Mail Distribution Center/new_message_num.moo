#46:new_message_num   this none this rxd

":new_message_num() => number that the next incoming message will receive.";
set_task_perms(caller_perms());
new = (msgs = caller.messages) ? msgs[$][1] + 1 | 1;
if (rmsgs = caller.messages_going)
  if (!rmsgs[1] || typeof(rmsgs[1][2]) == INT)
    rmsgs = rmsgs[2];
  endif
  lbrm = rmsgs[$][2];
  return max(new, lbrm[$][1] + 1);
else
  return new;
endif
