#6:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.home = this in {$no_one, $hacker, $generic_editor.owner} ? $nothing | $player_start;
  if (a = $list_utils:assoc(this, {{$prog, {$help_db["prog"], $help_db["builtin_function"], $help_db["verb"], $help_db["core"], $help_db["toaststunt"]}}, {$wiz, $help_db["wiz"]}, {$mail_recipient_class, $help_db["mail"]}, {$builder, $help_db["builder"]}, {$frand_class, $help_db["frand"]}}))
    this.help = a[2];
  else
    this.help = 0;
  endif
  if (this != $player)
    for p in ({"last_connect_place", "all_connect_places", "features", "previous_connection", "last_connect_time"})
      clear_property(this, p);
    endfor
    if (is_player(this))
      this.first_connect_time = $maxint;
      this.last_disconnect_time = $maxint;
    endif
  endif
endif
