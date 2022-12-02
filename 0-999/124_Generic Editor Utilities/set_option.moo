#124:set_option   this none this rxd

{player, option, value} = args;
if (!caller_perms().wizard)
  return E_PERM;
endif
options = player.inline_editor_options;
if (this.default_options[option] == #-1)
  return -1;
endif
if (options == 0)
  player.inline_editor_options = [];
endif
if (this.default_options[option] == value && option in player.inline_editor_options:keys())
  player.inline_editor_options = player.inline_editor_options:delete(option);
else
  player.inline_editor_options[option] = value;
endif
"Sacrificing sanity checks for tick savings.";
if (this:get_opt(option, player) == value)
  return value;
endif
return -1;
