#10:"wel*come @wel*come"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
else
  msg = this.welcome_message;
  version = server_version();
  for line in (typeof(msg) == LIST ? msg | {msg})
    if (typeof(line) == STR)
      notify(player, strsub(line, "%v", version));
    endif
  endfor
  this:check_player_db();
  this:check_for_shutdown();
  this:check_for_checkpoint();
  this:maybe_print_lag();
  return 0;
endif
