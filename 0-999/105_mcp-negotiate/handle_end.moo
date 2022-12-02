#105:handle_end   this none this rxd

if (caller == this)
  {connection, @rest} = args;
  connection:end_negotiation();
endif
