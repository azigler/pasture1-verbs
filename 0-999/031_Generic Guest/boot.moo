#31:boot   this none this rxd

if (!caller_perms().wizard)
  return;
endif
player = this;
this:notify(tostr("Sorry, but you've been here for ", $string_utils:from_seconds(connected_seconds(this)), " and someone else wants to be a guest now.  Feel free to come back", @$login:player_creation_enabled(player) ? {" or even create your own character if you want..."} | {" or type `create' to learn more about how to get a character of your own."}));
"boot_player(this)";
return;
"See #0:user_reconnected.";
