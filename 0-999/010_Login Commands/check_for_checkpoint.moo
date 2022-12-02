#10:check_for_checkpoint   this none this rxd

if (this.checkpoint_in_progress)
  line = "***************************************************************************";
  notify(player, "");
  notify(player, "");
  notify(player, line);
  notify(player, line);
  notify(player, "****");
  notify(player, "****  NOTICE:  The server is very slow now.");
  notify(player, "****           The database is being saved to disk.");
  notify(player, "****");
  notify(player, line);
  notify(player, line);
  notify(player, "");
  notify(player, "");
endif
