#126:options_menu   this none this rxd

"$menu_utils:options_menu(options[,input[,  menu_op]])";
"This is a menu verb, specifically intended for option menus that need complexity and robustness not provided by $option_utils.";
"It's only real purpose is option matching, not setting. Setting is left as an exercise to the programmer.";
"Options: This should be a list of maps with the following keys-";
"";
"       Name: The name, as displayed to the user";
"       Identifier: An internal identifier that's returned with the selection.";
"       State: The state of the option that should be displayed to the user, such as on or off.";
"       If the state is an integer, we'll automatically assume \"[red]Off[normal]\" for false booleans and \"[green]On[normal]\" for true ones.";
"";
"Input: Defaults to argstr, which should be set by the server before this verb is executed. This is used to optionally match on option names rather than printing a menu.";
"Menu_op: This is a map of options to pass to the corresponding menu call later.";
"This verb simply returns the corresponding number.";
"If the option has a corresponding identifier, this returns the identifier instead of the index.";
{options, ?input = argstr, ?menu_op = []} = args;
default_off = "[red]Off[normal]";
default_on = "[green]On[normal]";
if (input)
  menu_op["hidden_menu"] = 1;
  menu_op["invalid_selection_msg"] = "Invalid option.";
  menu_op["input"] = input;
  menu_op["kill_after_invalid_selection"] = 0;
endif
menu = {};
IDs = [];
names = {};
for x in (options)
  name = x["name"];
  names = {@names, name};
  if ("identifier" in x:keys())
    IDs[name] = x["identifier"];
  endif
  state = x["state"];
  if (typeof(state) == INT)
    display = state ? default_on | default_off;
  elseif (typeof(state) in {STR, ANON, OBJ} == 0)
    display = toliteral(state);
  else
    display = state;
  endif
  display = "[" + display + "]";
  menu = {@menu, {name, display}};
endfor
ret = this:menu(menu, menu_op);
if (ret == -1)
  return 0;
else
  if (names[ret] in IDs:keys())
    return IDs[names[ret]];
  else
    return ret;
  endif
endif
