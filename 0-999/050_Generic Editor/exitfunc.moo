#50:exitfunc   this none this rxd

if (!(who = (who_obj = args[1]) in this.active))
elseif (this:retain_session_on_exit(who))
  if (msg = this:no_littering_msg())
    who_obj:tell_lines(msg);
  endif
else
  this:kill_session(who);
endif
pass(@args);
