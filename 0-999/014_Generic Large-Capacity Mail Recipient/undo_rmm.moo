#14:undo_rmm   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
msgtree = this.messages;
seq = {};
last = 0;
"there are two possible formats here:";
"OLD: {{n,msgs},{n,msgs},...}";
"NEW: {kept_seq, {{n,msgs},{n,msgs},...}}";
going = this.messages_going;
if (going && (!going[1] || typeof(going[1][2]) == INT))
  kept = going[1];
  going = going[2];
else
  kept = {};
endif
for s in (going)
  msgtree = this._mgr:insert_after(msgtree, s[2], last + s[1]);
  seq = {@seq, last + s[1] + 1, (last = last + s[1] + s[2][2]) + 1};
endfor
this.messages = msgtree;
this.messages_going = {};
this.messages_kept = $seq_utils:union(kept, $seq_utils:expand(this.messages_kept, seq));
this:_fix_last_msg_date();
return seq;
