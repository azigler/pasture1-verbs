#154:@delete-folder   any any any rxd

"The front-end interface for deleting categories. (Now called folders!)";
categories = this.utils:print_category_tree(1, args ? 1 | 0);
choice = this.utils:standard_menu(categories, argstr);
if (choice == $failed_match)
  return player:tell("Invalid selection.");
else
  category = choice[2..$];
  crumbs = this.utils:category_breadcrumb(category, 1);
  if ($command_utils:yes_or_no(tostr("Are you sure you want to delete ", crumbs, "?")) != 1)
    return player:tell("Aborted.");
  endif
  result = `this.utils:delete_category(category) ! E_INVARG';
  if (result == E_INVARG)
    return player:tell("That folder has contents. Move or delete them first.");
  elseif (typeof(result) == ERR)
    return player:tell("An unknown error occurred.");
  else
    player:tell(crumbs, " deleted.");
  endif
endif
