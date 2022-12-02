#124:cmd_load   this none this rxd

{state} = args;
if (this:session_for(player) == $nothing)
  player:tell("You have no text saved.");
  return E_INVARG;
endif
if (state.text && $command_utils:yes_or_no("The current text will be lost. Are you sure you wish to load saved text?") == 0)
  player:tell("Aborted.");
  return E_INVARG;
endif
state.text = this:session_for(player).text;
player:tell("Saved text loaded.");
