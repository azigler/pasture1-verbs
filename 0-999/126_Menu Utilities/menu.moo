#126:menu   this none this rxd

"Usage: $menu_utils:menu(menu, options)";
"Menu: Should be a list of strings.";
"Options: A map containing option modifiers.";
"You can insert an _ in your menu if you wish to create a blank line and not include it in the numeric output.";
"Similarly, you can include ##<header> as a menu item if you want to render an automatically capitalized heading in the midst of your menu.";
SU = $string_utils;
{menu, ?options = 0} = args;
default_options = ["invalid_selection_msg" -> "Invalid selection.", "prompt" -> "Enter your selection:", "map_verb" -> "title", "kill_after_invalid_selection" -> 1, "expires_in" -> 0, "expired_msg" -> "Selection time expired; menu closed.", "target" -> player, "header_msg" -> 0, "blank_input_msg" -> 0, "input" -> 0, "hidden_menu" -> 0, "autofit_header" -> {}, "autofit_padding" -> 2, "columns" -> 0, "capitalize_string_entries" -> 1];
if (options == 0)
  options = default_options;
else
  for x in (mapkeys(default_options))
    if (x in mapkeys(options) == 0)
      options[x] = default_options[x];
    endif
  endfor
endif
if (typeof(options["prompt"]) == STR)
  options["  prompt"] = {options["prompt"]};
endif
player = options["target"];
names = {};
i = 0;
for x in (menu)
  number = 0;
  if (x == "_")
    "Blank Line";
    name = "";
    menu = setremove(menu, x);
  elseif (typeof(x) in {OBJ, ANON, WAIF} == 0 && length(x) > 2 && x[1..2] == "##")
    name = SU:capitalize_each(x[3..$]);
    menu = setremove(menu, x);
  elseif (typeof(x) in {OBJ, ANON, WAIF})
    i = i + 1;
    name = this:return_map_verb(x, options["map_verb"]);
    number = 1;
  elseif (typeof(x) == STR)
    i = i + 1;
    name = options["capitalize_string_entries"] ? x:capitalize_each() | x;
    number = 1;
  else
    name = x;
  endif
  if (number)
    name = tostr("[", i, "] ", name);
  endif
  names = {@names, name};
  $sin();
endfor
if (!options["hidden_menu"])
  options["header_msg"] != 0 && player:tell(options["header_msg"]);
  if (typeof(`menu[1] ! ANY => STR') == LIST)
    "Autofit the menu according to lengths.";
    for x in [1..length(names)]
      names[x] = {tostr("[", x, "]"), @names[x]};
    endfor
    header = options["autofit_header"];
    names = SU:autofit(header ? {header, @names} | names, options["autofit_padding"], header);
    if (header)
      "If we have a header, we need to move it to the right of the numeric options so that it's not a heading for the numbers.";
      space = SU:space(length(tostr(length(names))) + 4);
      "Two for brackets, two for space, the rest for how many numbers display";
      for x in [1..2]
        player:tell(space, names[x]);
      endfor
      names = names[3..$];
    endif
  endif
  if (options["columns"])
    player:tell_lines($ansi_utils:columnize(names, options["columns"], player:linelen()));
  else
    player:tell_lines(names);
  endif
endif
"Fork a task to kill the menu if a selection wasn't chosen in the given time period.";
if (options["expires_in"] > 0 && !options["hidden_menu"])
  menu_task_id = task_id();
  fork (options["expires_in"])
    if ($code_utils:task_valid(menu_task_id))
      kill_task(menu_task_id);
      player:tell(options["expired_msg"]);
    endif
  endfork
endif
if (!options["input"])
  options["hidden_menu"] && player:tell();
  player:tell_lines(options["prompt"]);
  player:notify(tostr("[Type a line of input or `@abort' to abort the command.]"));
  selection = read(player);
else
  selection = tostr(options["input"]);
endif
if (!selection && options["blank_input_msg"])
  player:tell(options["blank_input_msg"]);
  if (options["kill_after_invalid_selection"])
    return kill_task(task_id());
  else
    return 0;
  endif
elseif (SU:is_numeric(selection))
  selection = toint(selection);
  if (selection <= 0 || selection > length(menu))
    player:tell(options["invalid_selection_msg"]);
    if (options["kill_after_invalid_selection"])
      return kill_task(task_id());
    else
      return -1;
    endif
  endif
  return selection;
elseif (selection == "$")
  return length(menu);
elseif (selection == "^")
  return 1;
else
  if (selection != "")
    if (selection == "@abort")
      player:tell(">> Command Aborted <<");
      return kill_task(task_id());
    endif
    i = 0;
    matches = {};
    for x in (menu)
      if (x == "" || (length(x) > 2 && x[1..2] == "##"))
        continue;
      elseif (typeof(x) == LIST)
        x = x[1];
        "       x = $string_utils:from_list(x, \" \");";
      endif
      i = i + 1;
      for y in ($string_utils:words(x:strip_ansi()))
        if (index(y, selection) == 1)
          matches = {@matches, i};
        endif
      endfor
    endfor
    if (matches)
      if (length(matches) == 1)
        return matches[1];
      else
        match_menu = {};
        for x in (matches)
          match_menu = {@match_menu, menu[x]};
        endfor
        player:tell("Multiple matches were detected. Please be more specific.");
        for x in ({"hidden_menu", "input"})
          `options = options:delete(x) ! ANY';
        endfor
        return matches[this:menu(match_menu, options)];
      endif
    endif
  endif
  player:tell(options["invalid_selection_msg"]);
  if (options["kill_after_invalid_selection"])
    return kill_task(task_id());
  else
    return -1;
  endif
endif
