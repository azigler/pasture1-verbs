#106:cord_closed   this none this rxd

cord = caller;
session = cord.session;
this:send_closed(session, tostr(cord.id));
