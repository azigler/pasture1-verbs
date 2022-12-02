#88:@find   any none none rxd

"'@find #<object>', '@find <player>', '@find :<verb>' '@find .<property>' - Attempt to locate things. Verbs and properties are found on any object in the player's vicinity, and some other places.  '@find ?<help>' looks for a help topic on any available help database.";
if (!dobjstr)
  player:tell("Usage: '@find #<object>' or '@find <player>' or '@find :<verb>' or '@find .<property>' or '@find ?<help topic>'.");
  return;
endif
if (dobjstr[1] == ":")
  name = dobjstr[2..$];
  this:find_verb(name);
  return;
elseif (dobjstr[1] == ".")
  name = dobjstr[2..$];
  this:find_property(name);
  return;
elseif (dobjstr[1] == "#")
  target = toobj(dobjstr);
  if (!valid(target))
    player:tell(target, " does not exist.");
  endif
elseif (dobjstr[1] == "?")
  name = dobjstr[2..$];
  this:find_help(name);
  return;
else
  target = $string_utils:match_player(dobjstr);
  $command_utils:player_match_result(target, dobjstr);
endif
if (valid(target))
  player:tell(target.name, " (", target, ") is at ", valid(target.location) ? target.location.name | "Nowhere", " (", target.location, ").");
endif
