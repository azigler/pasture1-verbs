#57:"@untoad @detoad"   any any any rd

"@untoad <object> [as namespec]";
"Turns object into a player.  Anything that isn't a guest is chowned to itself.";
if (!player.wizard)
  player:notify("Yeah, right... you wish.");
elseif (prepstr && prepstr != "as")
  player:notify(tostr("Usage:  ", verb, " <object> [as name,alias,alias...]"));
elseif ($command_utils:object_match_failed(dobj, dobjstr))
elseif (prepstr && !(e = $building_utils:set_names(dobj, iobjstr)))
  player:notify(tostr("Initial rename failed:  ", e));
elseif (e = $wiz_utils:set_player(dobj, g = $object_utils:isa(dobj, $guest)))
  player:notify(tostr(dobj.name, "(", dobj, ") is now a ", g ? "usable guest." | "player."));
elseif (e == E_INVARG)
  player:notify(tostr(dobj.name, "(", dobj, ") is not of an appropriate player class."));
  player:notify("@chparent it to $player or some descendant.");
elseif (e == E_NONE)
  player:notify(tostr(dobj.name, "(", dobj, ") is already a player."));
elseif (e == E_NACC)
  player:notify("Wait until $player_db is finished updating...");
elseif (e == E_RECMOVE)
  player:notify(tostr("The name `", dobj.name, "' is currently unavailable."));
  player:notify(tostr("Try again with   ", verb, " ", dobj, " as <newname>"));
else
  player:notify(tostr(e));
endif
