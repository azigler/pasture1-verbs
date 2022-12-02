#46:undo_rmm   this none this rxd

":undo_rmm()  restores previously deleted messages in .messages_going to .messages.";
set_task_perms(caller_perms());
old = caller.messages;
going = caller.messages_going;
new = seq = {};
last = 0;
next = 1;
"there are two possible formats here:";
"OLD: {{n,msgs},{n,msgs},...}";
"NEW: {kept_seq, {{n,msgs},{n,msgs},...}}";
if (going && (!going[1] || typeof(going[1][2]) == INT))
  kept = going[1];
  going = going[2];
else
  kept = {};
endif
for s in (going)
  new = {@new, @old[last + 1..last + s[1]], @s[2]};
  last = last + s[1];
  seq = {@seq, next + s[1], next = length(new) + 1};
endfor
caller.messages = {@new, @old[last + 1..$]};
caller.messages_going = {};
caller.messages_kept = $seq_utils:union(kept, $seq_utils:expand(caller.messages_kept, seq));
if ($object_utils:has_callable_verb(caller, "_fix_last_msg_date"))
  caller:_fix_last_msg_date();
endif
return seq;
