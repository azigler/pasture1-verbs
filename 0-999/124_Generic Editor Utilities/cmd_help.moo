#124:cmd_help   this none this rxd

{state} = args;
player:tell("Command Help");
player:tell(dashes = "-------------");
cmds = vcmds = {};
for x in (verb_code(this, "editor"))
  line = $string_utils:trim(x);
  if (match = $string_utils:match_string(line, "*f (state.command in {*})"))
    "cmds = {@cmds, @$string_utils:to_value(match)[2]};";
    cmds = {@cmds, $string_utils:explode($string_utils:strip_all_but(match[2], $string_utils.alphabet + ",?/"), ",")};
  elseif (match = $string_utils:match_string(line, "*f (state.command == \"*\")"))
    cmds = {@cmds, {match[2]}};
  elseif (match = $string_utils:match_string(line, "elseif (state.verb && state.command == \"*\")"))
    vcmds = {@vcmds, {match[1]}};
  elseif (match = $string_utils:match_string(line, "elseif (state.verb && state.command in {*})"))
    vcmds = {@vcmds, $string_utils:explode($string_utils:strip_all_but(match[1], $string_utils.alphabet + ",?/"), ",")};
  elseif (match = $string_utils:match_string(line, "elseif (state.verb && state.extra && state.command == \"*\")"))
    vcmds = {@vcmds, {match[1]}};
  elseif (match = $string_utils:match_string(line, "elseif (state.verb && state.extra && state.command in {*})"))
    vcmds = {@vcmds, $string_utils:explode($string_utils:strip_all_but(match[1], $string_utils.alphabet + ",?/"), ",")};
  endif
endfor
ret = {};
if (!state.arg)
  ret = {@ret, "Help is available on the following topics:", ""};
  ret = {@ret, @$string_utils:columnize($list_utils:slice(player.programmer ? {@cmds, @vcmds} | cmds), 3)};
else
  for x in ({@cmds, @vcmds})
    if (x in vcmds && (player.programmer != 1 || !state.verb) || (state.arg && state.arg[1] in x == 0))
      continue x;
    endif
    ret = {@ret, tostr(x[1], "", length(x) > 1 ? tostr(" (Aliases: ", $string_utils:english_list(x[2..$]), ")") | "", ":")};
    if (ind = x[1] in $list_utils:slice(this.help))
      "                ret = {@ret, tostr($list_utils:slice(help, 2)[ind])};";
      ret = {@ret, @this.help[ind][2..$]};
    else
      ret = {@ret, "No help available."};
    endif
  endfor
endif
if (!ret)
  ret = {@ret, tostr("No help on that command is presently available. To see a list of commands, type ", this:get_opt("cmd_char", player), "help without arguments.")};
endif
player:tell_lines(ret);
player:tell(dashes);
if (!state.arg)
  player:tell();
  player:tell("To work with ranges, do one of the following:");
  player:tell("/delete 1..4 -- Erases lines 1 through 4.");
  player:tell("/delete 8..$ -- Erases up until the end of the text, starting at line 8.");
  player:tell("/list 3 4 -- Lists lines 3-4.");
  player:tell("/delete 1 -- Erases line 1.");
  player:tell("/list 40+40 -- Lists the contents of line 80.");
endif
