#121:handle_info   this none this rxd

if (caller != this)
  return E_PERM;
endif
{session, @stats} = args;
who = session.connection;
if (i = who in $list_utils:slice(this.client_info, 2))
  this.client_info = listset(this.client_info, {time(), who, stats}, i);
else
  this.client_info = {@this.client_info, {time(), who, stats}};
endif
