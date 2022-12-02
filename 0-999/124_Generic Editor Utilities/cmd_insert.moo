#124:cmd_insert   this none this rxd

{state} = args;
if (!state.arg)
  player:tell("Insert where? (Use a positive integer or '$' for the last line.)");
  return E_INVARG;
elseif (state.arg[1] != "$" && toint(state.arg[1]) <= 0 || toint(state.arg[1]) > length(state.text) + 1)
  player:tell("Insertion ranges from line 1 to ", length(state.text) + 1, ".");
  return E_INVARG;
endif
if (state.arg[1] == "$")
  state.ins = length(state.text) + 1;
else
  state.ins = toint(state.arg[1]);
endif
state.ins > 1 && this:list_line(state, state.ins - 1);
state.ins <= length(state.text) && this:list_line(state, state.ins);
player:tell("Now inserting before line ", state.ins, ".");
