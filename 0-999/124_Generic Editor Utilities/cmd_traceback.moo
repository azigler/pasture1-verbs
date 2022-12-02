#124:cmd_traceback   this none this rxd

{state} = args;
if (!state.traceback_line)
  player:tell("There are no recorded tracebacks.");
  return E_INVARG;
else
  if (state.traceback_line > 0 && state.traceback_line <= length(state.text) + 1)
    state.ins = state.traceback_line;
    player:tell("Insertion point is now at line '", state.ins, "'.");
  else
    player:tell("The recorded traceback line is no longer valid.");
  endif
endif
