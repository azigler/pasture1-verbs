#106:handle_   this none this rxd

{session, id, message, @assocs} = args;
if (caller == this)
  $mcp.cord:mcp_receive(id, message, assocs);
endif
