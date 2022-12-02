#106:finalize_connection   this none this rxd

session = caller;
len = length($mcp.cord.registry_ids);
for i in [0..len - 1]
  idx = len - i;
  cord = $mcp.cord.registry[idx];
  if (cord.session == session)
    $recycler:_recycle(cord);
  endif
endfor
