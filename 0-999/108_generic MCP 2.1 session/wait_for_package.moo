#108:wait_for_package   this none this rxd

{package, ?timeout} = args;
timeout = `timeout ! E_VARNF => -1';
if (v = this:handles_package(package))
  return v;
else
  return this:_add_package_waiter(package, timeout);
endif
