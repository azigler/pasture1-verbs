#108:end_negotiation   this none this rxd

if (caller == $mcp.negotiate)
  this:_signal_package_waiter(0);
endif
