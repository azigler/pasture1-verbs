#10:"req*uest @req*uest"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
endif
"must be #0:do_login_command";
if (!this.request_enabled)
  for line in ($generic_editor:fill_string(this:registration_string(), 70))
    notify(player, line);
  endfor
elseif (length(args) != 3 || args[2] != "for")
  notify(player, tostr("Usage:  ", verb, " <new-player-name> for <email-address>"));
elseif ($login:request_character(player, args[1], args[3]))
  boot_player(player);
endif
