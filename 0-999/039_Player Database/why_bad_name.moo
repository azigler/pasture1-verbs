#39:why_bad_name   this none this rxd

":why_bad_name(player, namespec) => Returns a message explaining why a player name change is invalid.  Stolen from APHiD's #15411:name_okay.";
who = args[1];
name = $building_utils:parse_names(args[2])[1];
si = index(name, " ");
qi = index(name, "\"");
bi = index(name, "\\");
ti = index(name, "	");
if (si || qi || bi || ti)
  return tostr("You may not use a name containing ", $string_utils:english_list({@si ? {"spaces"} | {}, @qi ? {"quotation marks"} | {}, @bi ? {"backslashes"} | {}, @ti ? {"tabs"} | {}}, "ERROR", " or "), ".  Try \"", strsub(strsub(strsub(strsub(name, " ", "_"), "\"", "'"), "\\", "/"), "	", "___"), "\" instead.");
elseif (name == "")
  return tostr("You may not use a blank name.");
elseif (i = index("*#()", name[1]))
  return tostr("You may not begin a name with the \"", "*#()"[i], "\" character.");
elseif (match(name, "(#[0-9]+)"))
  return tostr("A name can't contain a parenthesized object number.");
elseif (name in $player_db.stupid_names)
  return tostr("The name \"", name, "\" would probably cause problems in command parsing or similar usage.");
elseif (name in $player_db.reserved)
  return tostr("The name \"", name, "\" is reserved.");
elseif (length(name) > $login.max_player_name)
  return tostr("The name \"", name, "\" is too long.  Maximum name length is ", $login.max_player_name, " characters.");
elseif (valid(match = $player_db:find_exact(name)) && is_player(match) && who != match)
  return tostr("The name \"", name, "\" is already being used by ", match.name, "(", match, ").");
elseif ($player_db.frozen)
  return tostr("$player_db is not accepting new changes at the moment.");
elseif ($object_utils:has_callable_verb($local, "legal_name") && !$local:legal_name(name, who))
  return "That name is reserved.";
elseif (who in $wiz_utils.rename_restricted)
  return "This player is not allowed to change names.";
endif
