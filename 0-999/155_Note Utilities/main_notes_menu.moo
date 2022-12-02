#155:main_notes_menu   this none this rxd

":main_notes_menu(INT <category ID>)[, STR <user input>]";
"The guts of the @notes interface. This will allow you to drill down through categories.";
"If user input is specified, it will be passed along as the menu choice.";
{id, ?user_input = ""} = args;
notes = this:print_category_tree_with_notes(2, user_input, id, argstr || this:get_option("full_tree") ? 0 | 1, this:get_option("debug"));
choice = this:standard_menu(notes, user_input);
if (choice == $failed_match)
  return player:tell("Invalid selection.");
elseif (choice[1] == "N")
  return this:display_note(choice[2..$]);
elseif (choice[1] == "C")
  menu_length = 1;
  set_task_local(menu_length);
  return this:(verb)(choice[2..$]);
else
  return player:tell("That option appears to be invalid.");
endif
