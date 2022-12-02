#124:cmd_pass   this none this rxd

{state} = args;
passthrough = $string_utils:from_list(state.arg, " ");
force_input(player, passthrough);
suspend(0);
while ($command_utils:reading_input(player) && player:is_listening())
  yin();
endwhile
