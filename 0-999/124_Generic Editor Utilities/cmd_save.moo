#124:cmd_save   this none this rxd

{state} = args;
if (this:session_for(player, 1).text && $command_utils:yes_or_no("You already have text saved. Do you wish to overwrite it?") == 0)
  player:tell("Aborted.");
  return E_INVARG;
endif
if (!(state.arg in {0, {}}))
  range = this:parse_range(state.arg, length(state.text), state.ins);
  if (typeof(range) == STR)
    player:tell(range);
    return E_INVARG;
  endif
  {start, end} = range;
  text = state.text[start..end];
else
  text = state.text;
endif
this:session_for(player, 1).text = text;
this:session_for(player).last_modified = time();
player:tell("The text has been successfully saved. To load it in for editing later, type ", this:get_opt("cmd_char"), "paste.");
