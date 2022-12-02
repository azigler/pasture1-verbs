#108:finish   this none this rxd

if (caller == $mcp)
  this:_signal_package_waiter(E_INVARG);
  for package in ($list_utils:slice(this.packages))
    fork (0)
      package:finalize_connection();
    endfork
  endfor
  return $mcp:finalize_connection(this);
endif
