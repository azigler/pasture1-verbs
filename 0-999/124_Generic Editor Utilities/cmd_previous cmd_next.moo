#124:"cmd_previous cmd_next"   this none this rxd

{state} = args;
ins = state.ins;
if (verb == "cmd_previous")
  newins = ins - 1;
elseif (verb == "cmd_next")
  newins = ins + 1;
endif
if (newins < 1 || newins > state.text:length() + 1)
  player:tell("That would take you out of range (to line ", newins, ").");
  return E_INVARG;
else
  state.ins = newins;
  if (verb == "cmd_previous")
    state.ins != 1 ? this:list_line(state, state.ins - 1) | player:tell("____");
  elseif (verb == "cmd_next")
    state.ins != state.text:length() + 1 ? this:list_line(state, state.ins) | player:tell("^^^^");
  endif
endif
