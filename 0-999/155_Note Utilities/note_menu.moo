#155:note_menu   this none this rxd

":note_menu(STR <call verb>, INT <starting ID>[, STR <user input>])";
"A standard interface for parsing a note selection menu and passing that value off to a utility function.";
{call_verb, id, ?user_input = ""} = args;
notes = this:print_category_tree_with_notes(2, user_input, id, argstr || this:get_option("full_tree") ? 0 | 1, this:get_option("debug"));
choice = this:standard_menu(notes, user_input);
if (choice == $failed_match)
  return player:tell("Invalid selection.");
elseif (choice[1] == "C")
  menu_length = 1;
  set_task_local(menu_length);
  return this:(verb)(call_verb, choice[2..$]);
elseif (choice[1] == "N")
  note = choice[2..$];
else
  return player:tell("That choice appears to be invalid.");
endif
return this:(call_verb)(note);
