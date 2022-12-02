#121:handle_screensize   this none this rxd

{session, linelen, @args} = args;
if (caller != this)
  return E_PERM;
endif
(ll = toint(linelen)) > 0 && this:adjust_linelen(who = session.connection, who.linelen > 0 ? ll | -1 * ll);
