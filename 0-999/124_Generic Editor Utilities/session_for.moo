#124:session_for   this none this xd

{player, ?create = 0} = args;
if (!caller_perms().wizard)
  return E_PERM;
endif
session = 0;
for x in (this.sessions)
  if (x.last_modified != 0 && time() - x.last_modified > $time_utils.week)
    this.sessions = setremove(this.sessions, x);
  endif
  if (x.player == player)
    return x;
  endif
endfor
if (create)
  session = $edit_session:new();
  session.player = player;
  this.sessions = {@this.sessions, session};
  return session;
endif
return $nothing;
