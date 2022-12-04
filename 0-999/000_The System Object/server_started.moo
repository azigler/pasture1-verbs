#0:server_started   this none this rxd

if (!callers())
  $server["last_restart_time"] = time();
  $network:server_started();
  $login:server_started();
  $sqlite_interface:server_started();
endif
