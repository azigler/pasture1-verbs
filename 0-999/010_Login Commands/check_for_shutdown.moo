#10:check_for_shutdown   this none this rxd

when = $server["shutdown_time"] - time();
if (when >= 0)
  line = "***************************************************************************";
  notify(player, "");
  notify(player, "");
  notify(player, line);
  notify(player, line);
  notify(player, "****");
  notify(player, "****  WARNING:  The server will shut down in " + $time_utils:english_time(when - when % 60) + ".");
  for piece in ($generic_editor:fill_string($wiz_utils.shutdown_message, 60))
    notify(player, "****            " + piece);
  endfor
  notify(player, "****");
  notify(player, line);
  notify(player, line);
  notify(player, "");
  notify(player, "");
endif
