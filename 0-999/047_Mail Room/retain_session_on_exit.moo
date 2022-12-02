#47:retain_session_on_exit   this none this rxd

return this:ok(who = args[1]) && (this:sending(who) || pass(@args));
