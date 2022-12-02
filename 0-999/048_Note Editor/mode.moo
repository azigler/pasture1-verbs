#48:mode   any none none rd

"mode [string|list]";
if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
if (dobjstr && index("string", dobjstr) == 1)
  this.strmode[who] = mode = 1;
  player:tell("Now in string mode:");
elseif (dobjstr && index("list", dobjstr) == 1)
  this.strmode[who] = mode = 0;
  player:tell("Now in list mode:");
elseif (dobjstr)
  player:tell("Unrecognized mode:  ", dobjstr);
  player:tell("Should be one of `string' or `list'");
  return;
else
  player:tell("Currently in ", (mode = this.strmode[who]) ? "string " | "list ", "mode:");
endif
if (mode)
  player:tell("  store text as a single string instead of a list when possible.");
else
  player:tell("  always store text as a list of strings.");
endif
