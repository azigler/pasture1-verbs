#108:_add_package_waiter   this none this rxd

{package, timeout} = args;
if (caller == this)
  this.package_waiters = {@this.package_waiters, {package, task_id()}};
  if (timeout < 0)
    r = suspend();
  else
    r = suspend(timeout);
  endif
  this.package_waiters = setremove(this.package_waiters, {package, task_id()});
  return r;
endif
