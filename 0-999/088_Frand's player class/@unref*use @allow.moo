#88:"@unref*use @allow"   any any any rd

"'@unrefuse <action(s)> [ from <player> ]' - Stop refusing all of a list of actions. If a player is given, stop refusing actions by the player; otherwise, stop refusing all actions of the given kinds. '@unrefuse everything' - Remove all refusals.";
if (argstr == "everything")
  if ($command_utils:yes_or_no("Do you really want to erase all your refusals?"))
    this:clear_refusals();
    player:tell("OK, they are gone.");
  else
    player:tell("OK, no harm done.");
  endif
  return;
endif
stuff = this:parse_refuse_arguments(argstr);
if (!stuff)
  return;
endif
"'stuff' is now in the form {<origin>, <actions>, <duration>}.";
origins = stuff[1];
actions = stuff[2];
if (typeof(origins) != LIST)
  origins = {origins};
endif
n = 0;
for origin in (origins)
  n = n + this:remove_refusal(origin, actions);
endfor
plural = n == 1 && length(origins) == 1 ? "" | "s";
if (n)
  player:tell("Refusal", plural, " removed.");
else
  player:tell("You have no such refusal", plural, ".");
endif
