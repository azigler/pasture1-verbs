#155:print_category*_with_notes   this none this rxd

":print_category*_with_notes(INT category parent id[, STR prefix, INT debug, INT menuize, INT silent]) => LIST";
"Beginning with the parent ID <id>, recurse through the category tree and print each name.";
"If the verb is 'print_category_with_notes', note titles will be printed below the categories they're in.";
"If specified, <prefix> will be prefixed in front of each category name. This should probably not be changed from the default, as certain assumptions are made in this verb about what prefix may be.";
"If <debug> is true, category and note IDs will be printed in parenthesis after the category name.";
"If <menuize> is any true value, each entry will be prefixed with a number suitable for selecting from a menu. If menuize is specifically 2 and the verb name includes '_with_notes', notes are included in the menu.";
"";
"If silent is true, the tree won't actually be printed, but the return result will still be returned as if the tree had been printed.";
"Depth refers to how many sub-categories you want to display for each category. The default value, 0, means to print as many categories as there are.";
"The return value is a list of all displayed menu IDs. Category IDs are prefixed with either a 'C' for category or an 'N' for note. e.g. C5 indicates the category with ID 5.";
{id, ?prefix = "  ", ?debug = 0, ?menuize = 0, ?silent = 0, ?depth = 0} = args;
try
  displayed_depth = 1;
  print_notes = verb == "print_category_with_notes";
  subcategories = this:subcategories_of(id, 1);
  subcategory_length = length(subcategories);
  "Entry_prefix is anything that gets prefixed per-iteration. Right now this is only used to display menu numbers.";
  entry_prefix = note_entry_prefix = "";
  "Menu_length keeps count of which menu option we're presenting. It gets incremented each time and stored in task_local so as to be available during recursion.";
  menu_length = menuize > 0 && typeof(task_local()) == NUM ? task_local() | 1;
  ret = {};
  if (print_notes)
    for x in (this:notes_in_category(id))
      if (menuize == 2)
        ret = {@ret, tostr("N", x)};
        note_entry_prefix = tostr("[[bold][yellow]", menu_length, "[normal]] ");
        menu_length = menu_length + 1;
      endif
      if (!silent)
        player:tell(prefix, note_entry_prefix, this:get_note_title(x), debug ? tostr(" {[red]", x, "[normal]}") | "");
      endif
    endfor
  endif
  for i in [1..subcategory_length]
    {id, name} = subcategories[i];
    if (menuize > 0)
      ret = {@ret, tostr("C", id)};
      entry_prefix = tostr("[[bold][yellow]", menu_length, "[normal]] ");
      menu_length = menu_length + 1;
    endif
    if (!silent)
      player:tell(prefix, entry_prefix, "(", name, ")", debug ? tostr(" {[red]", id, "[normal]}") | "");
    endif
    if (i == subcategory_length)
      "The last category shouldn't point to nothing with the solid bar, so we scooch it back over.";
      indented_prefix = tostr(prefix[1..$ - 4], "    |--");
    else
      indented_prefix = tostr(prefix[1..$ - 2], "  |--");
    endif
    if (depth == 0 || displayed_depth < depth)
      displayed_depth = displayed_depth + 1;
      set_task_local(menu_length);
      ret = {@ret, @this:(verb)(id, indented_prefix, debug, menuize, silent)};
      menu_length = task_local();
    endif
  endfor
  "Since we're printing files at the top, we need to make sure menu_length gets stored regardless of the displayed depth.";
  set_task_local(menu_length);
  return ret;
except error (ANY)
  $debug(#7, toliteral(error));
endtry
