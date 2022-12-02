#14:list_rmm   this none this rxd

if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
len = 0;
getmsg = this.summary_uses_body ? "_message_text" | "_message_hdr";
going = this.messages_going;
if (going && (!going[1] || typeof(going[1][2]) == INT))
  kept = {@going[1], $maxint};
  going = going[2];
else
  kept = {$maxint};
endif
k = 1;
mcount = 0;
for s in (going)
  if (kept[k] <= (mcount = mcount + s[1]))
    k = k + 1;
  endif
  len = len + s[2][2];
  handle = this._mgr:start(s[2], 1, s[2][2]);
  while (handle)
    for x in (handle[1])
      if (kept[k] <= (mcount = mcount + 1))
        k = k + 1;
      endif
      player:tell($string_utils:right(this:_message_num(@x), 4), k % 2 ? ":  " | ":= ", this:msg_summary_line(@this:(getmsg)(@x)));
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
endfor
if (len)
  player:tell("----+");
endif
return len;
