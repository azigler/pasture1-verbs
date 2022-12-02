#124:do_add_line   this none this rxd

{state, line} = args;
if (`line[1] == this:get_option("escape_char") ! ANY' && length(line) > 1)
  line = line[2..$];
endif
if (state.ins > length(state.text))
  state.text = {@state.text, line};
else
  state.text = {@state.text[1..state.ins - 1], line, @state.text[state.ins..$]};
endif
!this:get_option("no_line_notifies") && player:tell("Line ", state.ins, " added.");
this:log_last_edit(player, task_id());
state.ins = state.ins + 1;
