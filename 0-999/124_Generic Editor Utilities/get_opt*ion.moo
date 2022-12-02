#124:get_opt*ion   this none this rxd

"-1 == option not found";
{option, ?player = player} = args;
opt = `player.inline_editor_options[option] ! ANY => $nothing';
if (opt != $nothing)
  return opt;
else
  return $edit_utils.default_options[option];
endif
