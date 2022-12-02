#124:cmd_show_clipboard   this none this rxd

{state} = args;
saved = this:session_for(player, 1);
if (!saved.text)
  player:tell("You have no text saved.");
  return E_INVARG;
else
  player:tell("You have the following text saved:");
  player:tell();
  player:tell_lines_suspended(saved.text);
  player:tell();
  player:tell("(end of saved text)");
endif
