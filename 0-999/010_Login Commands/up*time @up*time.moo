#10:"up*time @up*time"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
else
  notify(player, tostr("The server has been up for ", $time_utils:english_time(time() - $server["last_restart_time"]), "."));
  return 0;
endif
