#14:expunge_rmm   this none this rxd

if (!this:ok_write(caller, caller_perms()))
  return E_PERM;
endif
len = 0;
going = this.messages_going;
if (going && (!going[1] || typeof(going[1][2]) == INT))
  going = going[2];
endif
for s in (going)
  len = len + s[2][2];
  this._mgr:kill(s[2], "_killmsg");
endfor
this.messages_going = {};
return len;
