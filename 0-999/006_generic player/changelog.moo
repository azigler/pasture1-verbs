#6:changelog   any any any rxd

"syntax: changelog <argument>";
"Arg is one of";
"number, checks the last <x> entries.";
"(if no argument is provided, checks last 5-- entries. Each entry is considered a date, each date containing unlimited subentries.)";
"Add, edit, remove, self explanatory. Only available to wizards.";
if (!args)
  player:tell("Numeric value not specified; reading last ", $changelog:entries_to(), " " + $ies("entry", $changelog:entries_to()) + ".");
  return player:tell_lines($changelog:read());
endif
{what, ?subarg = ""} = args;
if (toint(what) >= 1)
  player:tell("Last " + what + " " + $ies("entry", what));
  return player:tell_lines($changelog:read(toint(what)));
endif
if (what in {"add", "edit", "remove"} && !player.wizard)
  return player:tell("You cannot modify this.");
endif
if (what == "add")
  player:tell("What entries would you like to add?");
  subarg = $command_utils:read_lines();
  for i, count in (subarg)
    subarg[count] = subarg[count] + " (" + player.name + ")";
  endfor
  if ($command_utils:yes_or_no("Are you sure you would like to add the following entries? " + $string_utils:english_list(subarg) + "."))
    $changelog:add(subarg);
    player:tell("Added successfully.");
    for i in (setremove(connected_players(), player))
      i:tell("[CHANGELOG] New entries have been posted.");
    endfor
  else
    return player:tell("Aborted.");
  endif
elseif (what in {"edit", "remove"})
  $changelog:(what)();
  for i in (setremove(connected_players(), player))
    i:tell("[CHANGELOG] An entry has been ", what, "", what[$] == "e" && "d" || "ed", ".");
  endfor
  player:tell(what + " successful.");
endif
"Last modified Mon Dec  5 17:51:33 2022 UTC by caranov (#133).";
