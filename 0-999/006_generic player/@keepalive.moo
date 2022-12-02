#6:@keepalive   none none none rxd

player.keep_alive = !player.keep_alive;
player:tell("Keep Alive has been ", player.keep_alive ? "enabled" | "disabled", ".");
