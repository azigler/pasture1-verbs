#154:@add-folder   any any any rxd

"The front-end interface for adding new categories. (Now called folders!)";
if (!args)
  player:tell("Enter a folder name:");
  name = $command_utils:read();
else
  name = argstr;
endif
if ($command_utils:yes_or_no("Is this a top-level folder?") == 1)
  category = 1;
else
  player:tell("Select a folder to put '", name, "' in:");
  categories = this.utils:print_category_tree(1, args ? 1 | 0);
  choice = this.utils:standard_menu(categories);
  if (choice == $failed_match)
    return player:tell("Invalid selection.");
  else
    category = choice[2..$];
  endif
endif
new_category = this.utils:add_category(category, name);
player:tell(this.utils:category_breadcrumb(new_category, 1), " added!");
