#124:cmd_delete   this none this rxd

{state} = args;
if (!state.text)
  player:tell("There is no text to delete.");
else
  range = this:parse_range(state.arg, length(state.text), state.ins);
  if (!state.arg)
    if (state.ins - 1 <= 0)
      range = {state.ins, state.ins};
    else
      range = {state.ins - 1, state.ins - 1};
    endif
  endif
  if (typeof(range) == STR)
    player:tell(range);
    return E_INVARG;
  endif
  {start, end} = range;
  for x in [start..end]
    player:tell("   ", state.text[start]);
    state.text = listdelete(state.text, start);
  endfor
  state.ins = start;
  if (state.ins > length(state.text) + 1)
    state.ins = length(state.text) + 1;
  endif
  player:tell("---Line", end > start ? "s" | "", " deleted. Insertion point is before line ", state.ins, ".");
endif
