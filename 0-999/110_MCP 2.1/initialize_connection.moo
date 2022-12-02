#110:initialize_connection   this none this rxd

{who} = args;
if (caller != this)
  raise(E_PERM);
endif
return this:create_session(who);
