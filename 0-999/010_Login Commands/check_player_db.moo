#10:check_player_db   this none this rxd

if ($player_db.frozen)
  line = "***************************************************************************";
  notify(player, "");
  notify(player, line);
  notify(player, "***");
  for piece in ($generic_editor:fill_string("The character-name matcher is currently being reloaded.  This means your character name might not be recognized even though it still exists.  Don't panic.  You can either wait for the reload to finish or you can connect using your object number if you remember it (e.g., `connect #1234 yourpassword').", 65))
    notify(player, "***       " + piece);
  endfor
  notify(player, "***");
  for piece in ($generic_editor:fill_string("Repeat:  Do not panic.  In particular, please do not send mail to any wizards or the registrar asking about this.  It will finish in time.  Thank you for your patience.", 65))
    notify(player, "***       " + piece);
  endfor
  if (this:player_creation_enabled(player))
    notify(player, "***       This also means that character creation is disabled.");
  endif
  notify(player, "***");
  notify(player, line);
  notify(player, "");
endif
