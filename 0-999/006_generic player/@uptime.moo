#6:@uptime   none none none rd

player:notify(tostr($network.MOO_name, " has been up for ", $time_utils:english_time(time() - $server["last_restart_time"], $server["last_restart_time"]), "."));
