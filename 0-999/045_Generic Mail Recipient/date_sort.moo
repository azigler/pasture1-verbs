#45:date_sort   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
date_seq = {};
for msg in (this.messages)
  date_seq = {@date_seq, msg[2][1]};
endfor
msg_order = $list_utils:sort($list_utils:range(n = length(msgs = this.messages)), date_seq);
newmsgs = {};
for i in [1..n]
  if ($command_utils:suspend_if_needed(0))
    player:tell("...", i);
  endif
  newmsgs = {@newmsgs, {i, msgs[msg_order[i]][2]}};
endfor
if (length(this.messages) != n)
  "...shit, new mail received,... start again...";
  fork (0)
    this:date_sort();
  endfork
else
  this.messages = newmsgs;
  this.last_used_time = newmsgs[$][2][1];
endif
