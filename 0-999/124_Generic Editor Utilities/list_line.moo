#124:list_line   this none this rxd

$ansi_utils:add_noansi();
{state, line} = args;
f = 1 + (line in {(ins = state.ins) - 1, ins});
text = state.text[line];
player:tell($string_utils:right(line, 3, " _^"[f]), ":_^"[f], " ", text);
$ansi_utils:remove_noansi();
