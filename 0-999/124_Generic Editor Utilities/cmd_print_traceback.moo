#124:cmd_print_traceback   this none this rxd

{state} = args;
if (!state.traceback)
  player:tell("There are no recorded tracebacks.");
  return E_INVARG;
else
  player:tell("Last recorded traceback:");
  player:tell_lines(state.traceback);
endif
