#14:new_message_num   this none this rxd

if (this:ok(caller, caller_perms()))
  new = (msgtree = this.messages) ? this:_message_num(@this._mgr:find_nth(msgtree, msgtree[2])) + 1 | 1;
  if (rmsgs = this.messages_going)
    lbrm = rmsgs[$][2];
    return max(new, this:_message_num(@this._mgr:find_nth(lbrm, lbrm[2])) + 1);
  else
    return new;
  endif
else
  return E_PERM;
endif
