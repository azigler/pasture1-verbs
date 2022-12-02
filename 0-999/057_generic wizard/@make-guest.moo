#57:@make-guest   any none none rd

"Usage:  @make-guest <guestname>";
"Creates a player called <guestname>_Guest owned by $hacker and a child of $guest. Or, if $local.guest exists, make a child of that, assuming that all other guests are children of it too.";
if (!player.wizard)
  player:tell("If you think this MOO needs more guests, you should contact a wizard.");
  return E_PERM;
endif
if (length(args) != 1)
  player:tell("Usage: ", verb, " <guest name>");
  return;
endif
guest_parent = $object_utils:has_property($local, "guest") && valid($local.guest) && $object_utils:isa($local.guest, $guest) ? $local.guest | $guest;
i = length(children(guest_parent));
while (!$player_db:available(guestnum = tostr("Guest", i = i + 1)))
endwhile
guestname = args[1] + "_Guest";
guestaliases = {guestname, adj = args[1], guestnum};
if (!player.wizard)
  return;
elseif ($player_db.frozen)
  player:tell("Sorry, the player db is frozen, so no players can be made right now.  Please try again in a few minutes.");
  return;
elseif (!$player_db:available(guestname))
  player:tell("\"", guestname, "\" is not an available name.");
  return;
elseif (!$player_db:available(adj))
  player:Tell("\"", adj, "\" is not an available name.");
  return;
else
  new = $quota_utils:bi_create(guest_parent, $hacker);
  new:set_name(guestname);
  new:set_aliases(guestaliases);
  if (!(e = $wiz_utils:set_player(new, 1)))
    player:Tell("Unable to make ", new.name, " (", new, ") a player.");
    player:Tell(tostr(e));
  else
    player:Tell("Guest: ", new.name, " (", new, ") made.");
    new.default_description = {"By definition, guests appear nondescript."};
    new.description = new.default_description;
    new.last_connect_time = $maxint;
    new.last_disconnect_time = time();
    new.password = 0;
    new.size_quota = new.size_quota;
    new:set_gender(new.default_gender);
    move(new, $player_start);
    player:tell("Now don't forget to @describe ", new, " as something.");
  endif
endif
