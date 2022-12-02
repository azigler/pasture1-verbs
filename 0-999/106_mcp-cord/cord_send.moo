#106:cord_send   this none this rxd

{message, alist} = args;
cord = caller;
session = cord.session;
if (cord in $mcp.cord.registry)
  return this:send_(session, tostr(cord.id), message, @alist);
else
  raise(E_PERM);
endif
