#6:@mode   any any any rd

"@mode <mode>";
"Current modes are brief and verbose.";
"General verb for setting player `modes'.";
"Modes are coded right here in the verb.";
if (caller != this)
  player:tell("You can't set someone else's modes.");
  return E_PERM;
endif
modes = {"brief", "verbose"};
mode = `modes[$string_utils:find_prefix(dobjstr, modes)] ! E_TYPE, E_RANGE => 0';
if (!mode)
  player:tell("Unknown mode \"", dobjstr, "\".  Known modes:");
  for mode in (modes)
    player:tell("  ", mode);
  endfor
  return 0;
elseif (mode == "brief")
  this:set_brief(1);
elseif (mode == "verbose")
  this:set_brief(0);
endif
player:tell($string_utils:capitalize(mode), " mode set.");
return 1;
