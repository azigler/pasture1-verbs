#105:do_negotiation   this none this rxd

connection = caller;
for keyval in ($mcp.registry:packages())
  {name, package} = keyval;
  this:send_can(connection, name, @package.version_range);
endfor
this:send_end(connection);
