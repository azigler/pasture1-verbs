#0:"user_disconnected user_client_disconnected"   this none this rxd

if (callers())
  return;
endif
if (args[1] < #0)
  "not logged in user.  probably should do something clever here involving Carrot's no-spam hack.  --yduJ";
  "...'forget' that we already performed a name lookup on this connection...";
  $login:delete_name_lookup(args[1]);
  return;
endif
$mcp:(verb)(@args);
user = args[1];
user.last_disconnect_time = time();
set_task_perms(user);
where = user.location;
`user:disfunc() ! ANY => 0';
if (user.location != where)
  `where.location:disfunc(user) ! ANY => 0';
endif
`user.location:disfunc(user) ! ANY => 0';
