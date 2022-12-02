#31:log   this none this rxd

":log(islogin,time,where) adds an entry to the connection log for this guest.";
if (caller != this)
  return E_PERM;
elseif (length(this.connect_log) < this.max_connect_log)
  this.connect_log = {args, @this.connect_log};
else
  this.connect_log = {args, @this.connect_log[1..this.max_connect_log - 1]};
endif
