#21:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.classes = {$player, $room, $exit, $note, $container, $thing, $feature, $mail_recipient, $generic_help, $generic_db, $generic_utils, $generic_options};
endif
