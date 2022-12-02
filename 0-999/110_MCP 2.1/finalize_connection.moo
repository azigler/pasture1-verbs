#110:finalize_connection   this none this rxd

{con} = args;
if (caller == con)
  this:destroy_session(con);
endif
