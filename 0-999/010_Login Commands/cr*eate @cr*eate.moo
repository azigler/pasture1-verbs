#10:"cr*eate @cr*eate"   any none any rxd

if (caller != #0 && caller != this)
  return E_PERM;
  "... caller isn't :do_login_command()...";
elseif (!this:player_creation_enabled(player))
  notify(player, this:registration_string());
  "... we've disabled player creation ...";
elseif (length(args) != 2)
  notify(player, tostr("Usage:  ", verb, " <new-player-name> <new-password>"));
elseif ($player_db.frozen)
  notify(player, "Sorry, can't create any new players right now.  Try again in a few minutes.");
elseif (!(name = args[1]) || name == "<>")
  notify(player, "You can't have a blank name!");
  if (name)
    notify(player, "Also, don't use angle brackets (<>).");
  endif
elseif (name[1] == "<" && name[$] == ">")
  notify(player, "Try that again but without the angle brackets, e.g.,");
  notify(player, tostr(" ", verb, " ", name[2..$ - 1], " ", strsub(strsub(args[2], "<", ""), ">", "")));
  notify(player, "This goes for other commands as well.");
elseif (index(name, " "))
  notify(player, "Sorry, no spaces are allowed in player names.  Use dashes or underscores.");
  "... lots of routines depend on there not being spaces in player names...";
elseif (!$player_db:available(name) || this:_match_player(name) != $failed_match)
  notify(player, "Sorry, that name is not available.  Please choose another.");
  "... note the :_match_player call is not strictly necessary...";
  "... it is merely there to handle the case that $player_db gets corrupted.";
elseif (!(password = args[2]))
  notify(player, "You must set a password for your player.");
else
  new = $quota_utils:bi_create($player_class, $nothing);
  set_player_flag(new, 1);
  new.name = name;
  new.aliases = {name};
  new.programmer = $player_class.programmer;
  new.password = $login:encrypt_password(password);
  new.last_password_time = time();
  new.last_connect_time = $maxint;
  "Last disconnect time is creation time, until they login.";
  new.last_disconnect_time = time();
  "make sure the owership quota isn't clear!";
  $quota_utils:initialize_quota(new);
  this:record_connection(new);
  $player_db:insert(name, new);
  `move(new, $player_start) ! ANY';
  return new;
endif
return 0;
