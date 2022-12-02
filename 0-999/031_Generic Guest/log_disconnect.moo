#31:log_disconnect   this none this rxd

if (caller != this)
  return E_PERM;
else
  $guest_log:enter(0, time(), $string_utils:connection_hostname(this in connected_players(1) ? this | this.last_connect_place));
endif
