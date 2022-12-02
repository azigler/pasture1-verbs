#14:rm_message_seq   this none this rxd

seq = args[1];
if (!(this:ok_write(caller, caller_perms()) || (this:ok(caller, caller_perms()) && (seq = this:own_messages_filter(caller_perms(), @args)))))
  return E_PERM;
endif
msgtree = this.messages;
save = nums = {};
onext = 1;
rmmed = 0;
for i in [1..length(seq) / 2]
  if ($command_utils:suspend_if_needed(0))
    player:tell("... rmm ", onext);
    suspend(0);
  endif
  start = seq[2 * i - 1];
  next = seq[2 * i];
  {msgtree, zmsgs} = this._mgr:extract_range(msgtree, start - rmmed, next - 1 - rmmed);
  save = {@save, {start - onext, zmsgs}};
  nums = {@nums, this:_message_num(@this._mgr:find_nth(zmsgs, 1)), this:_message_num(@this._mgr:find_nth(zmsgs, zmsgs[2])) + 1};
  onext = next;
  rmmed = rmmed + next - start;
endfor
tmg = this.messages_going;
save_kept = $seq_utils:intersection(this.messages_kept, seq);
this.messages_kept = $seq_utils:contract(this.messages_kept, seq);
this.messages_going = save_kept ? {save_kept, save} | save;
fork (0)
  for s in (tmg)
    this._mgr:kill(s[2], "_killmsg");
  endfor
endfork
this.messages = msgtree;
this:_fix_last_msg_date();
return $seq_utils:tostr(nums);
