#124:options   this none this xd

{?argstr = 0} = args;
options = {};
options = {@options, ["name" -> "Set Command Prefix", "identifier" -> "prefix", "state" -> tostr(this:get_option("cmd_char"))]};
options = {@options, ["name" -> "Set Escape Character", "identifier" -> "escape", "state" -> tostr(this:get_option("escape_char"))]};
options = {@options, ["name" -> "Advanced Mode (suppresses warnings and help prompts)", "identifier" -> "expert", "state" -> this:get_option("expert")]};
options = {@options, ["name" -> "Suppress Line Added Notifications", "identifier" -> "suppress", "state" -> this:get_option("no_line_notifies")]};
options = {@options, ["name" -> "Color Line Numbers", "identifier" -> "color_line", "state" -> (color = this:get_option("color_line")) != "" ? tostr($ansi_utils:hr_to_code(color), color, "[normal]") | 0]};
options = {@options, ["name" -> "Color Line Indicator", "identifier" -> "color_indicator", "state" -> (color = this:get_option("color_indicator")) != "" ? tostr($ansi_utils:hr_to_code(color), color, "[normal]") | 0]};
options = {@options, ["name" -> "Set As Default Editor For Verbs and Notes", "identifier" -> "default_editor", "state" -> this:get_option("default_editor")]};
if (player.programmer)
  options = {@options, ["name" -> "Jump to Error Line", "identifier" -> "jump_to_error", "state" -> this:get_option("jump_to_error")]};
endif
opt = $menu_utils:options_menu(options);
if (opt == 0)
  return;
endif
if (opt == "prefix")
  player:tell("Enter a single character that you wish to begin editor commands with. It should preferably be a symbol, not a letter or number.");
  cmd = $command_utils:read();
  if (length(cmd) > 1 || cmd in $string_utils:char_list($string_utils.alphabet + $string_utils.digits) || length(cmd) <= 0)
    return player:tell("Invalid command prefix. It should not be a number or letter and must be one (1) character in length.");
  endif
  result = this:set_option(player, "cmd_char", cmd);
  if (typeof(result) != STR)
    player:tell("There was an error setting your command prefix.");
  else
    player:tell("Command prefix set.");
  endif
elseif (opt == "escape")
  player:tell("Enter a single character that you wish to escape lines with. When lines are started with this character, any editor parsing will be bypassed. It should preferably be a symbol, not a letter or number.");
  esc = $command_utils:read();
  if (length(esc) > 1 || esc in $string_utils:char_list($string_utils.alphabet + $string_utils.digits) || length(esc) <= 0)
    return player:tell("Invalid escape character. It should not be a number or letter and must be one (1) character in length.");
  endif
  result = this:set_option(player, "escape_char", esc);
  if (typeof(result) != STR)
    player:tell("There was an error setting your escape character.");
  else
    player:tell("Escape character set.");
  endif
elseif (opt == "expert")
  opt = !this:get_option("expert");
  result = this:set_option(player, "expert", opt);
  player:tell("You ", opt ? "activate" | "deactivate", " advanced mode.");
elseif (opt == "suppress")
  opt = !this:get_option("no_line_notifies");
  result = this:set_option(player, "no_line_notifies", opt);
  player:tell(opt ? "You will no longer receive a message when a line has been added to the working text." | "You will once again receive a message when a line has been added to the working text.");
elseif (opt == "default_editor")
  opt = !this:get_option("default_editor");
  result = this:set_option(player, "default_editor", opt);
  player:tell(opt ? "When editing verbs or notes, you will now use the inline editor by default." | "You will no longer use the inline editor to edit verbs and notes.");
elseif (opt == "jump_to_error")
  opt = !this:get_option("jump_to_error");
  result = this:set_option(player, "jump_to_error", opt);
  player:tell(opt ? "When editing verbs, the cursor will move to the line indicated in the traceback if an error occurs." | "The cursor will no longer move to the traceback line when errors occur.");
elseif (opt == "color_line")
  option = "color_line";
  status = this:get_option(option);
  if (status != "" && $command_utils:yes_or_no("Would you like to select a different color?") == 1 || status == "")
    choice = $ansi_utils:color_selector();
    this:set_option(player, option, choice);
    player:tell("Color set.");
  else
    this:set_option(player, option, "");
    player:tell("Color cleared.");
  endif
elseif (opt == "color_indicator")
  option = "color_indicator";
  status = this:get_option(option);
  if (status != "" && $command_utils:yes_or_no("Would you like to select a different color?") == 1 || status == "")
    choice = $ansi_utils:color_selector();
    this:set_option(player, option, choice);
    player:tell("Color set.");
  else
    this:set_option(player, option, "");
    player:tell("Color cleared.");
  endif
endif
