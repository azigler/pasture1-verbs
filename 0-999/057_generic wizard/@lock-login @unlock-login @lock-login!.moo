#57:"@lock-login @unlock-login @lock-login!"   any any any rd

"Syntax:  @lock-login <message>";
"         @lock-login! <message>";
"         @unlock-login";
"";
"The @lock-login calls prevent all non-wizard users from logging in, displaying <message> to them when they try.  (The second syntax, with @lock-login!, additionally boots any nonwizards who are already connected.)  @unlock-login turns this off.";
if (caller != this)
  raise(E_PERM);
elseif (verb[2] == "u")
  $login.no_connect_message = 0;
  player:notify("Login restrictions removed.");
elseif (!argstr)
  player:notify("You must provide some message to display to users who attempt to login:  @lock-login <message>");
else
  $login.no_connect_message = argstr;
  player:notify(tostr("Logins are now blocked for non-wizard players.  Message displayed when attempted:  ", $login.no_connect_message));
  if (verb == "@lock-login!")
    wizards = $wiz_utils:all_wizards_unadvertised();
    for x in (connected_players())
      if (!(x in wizards))
        boot_player(x);
      endif
    endfor
    player:notify("All nonwizards have been booted.");
  endif
endif
