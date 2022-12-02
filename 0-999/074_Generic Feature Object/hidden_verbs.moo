#74:hidden_verbs   this none this rxd

"Can't see `get' unless it's in the room; can't see `drop' unless it's in the player.  Should possibly go on $thing.";
"Should use :contents, but I'm in a hurry.";
hidden = pass(@args);
if (this.location != args[1])
  hidden = setadd(hidden, {$thing, verb_info($thing, "drop")[3], {"this", "none", "none"}});
  hidden = setadd(hidden, {$thing, verb_info($thing, "give")[3], {"this", "at/to", "any"}});
endif
if (this.location != args[1].location)
  hidden = setadd(hidden, {$thing, verb_info($thing, "get")[3], {"this", "none", "none"}});
endif
return hidden;
