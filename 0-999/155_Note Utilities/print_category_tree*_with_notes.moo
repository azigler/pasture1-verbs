#155:print_category_tree*_with_notes   this none this rxd

":print_category_tree*_with_notes([INT menuize, INT silent, INT <starting id>, INT debug]) => LIST";
"Print the entire list of categories as a hierarchical tree.";
"If the verb is 'print_category_tree_with_notes', the titles of notes will be printed under each category.";
"If menuize is true, each category or note will be prefixed with a number for selection from a menu.";
"If silent is true, the tree won't actually be printed, but the return result will still be returned as if the tree had been printed.";
"If starting id is specified, that's the first category to be processed.";
"Depth is the number of subcategories to display. See documentation for print_category.";
"If debug is true, the category and note IDs will be printed in parenthesis.";
"See 'print_category' documentation for return value.";
{?menuize = 0, ?silent = 0, ?starting_id = 1, ?depth = 0, ?debug = this:get_option("debug", player)} = args;
indent = "|--";
if (!silent)
  player:tell("[Root]");
endif
verb_call = verb == "print_category_tree_with_notes" ? "print_category_with_notes" | "print_category";
return this:(verb_call)(starting_id, indent, debug, menuize, silent, depth);
