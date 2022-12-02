#155:category_breadcrumb   this none this rxd

":category_breadcrumb(STR <category id>[, INT <include first>]) => STR";
"Return a string showing the hierarchy of the given category. e.g. 'Root -> Stuff -> Things";
"If <include first> is true, the breadcrumb list will always end with the category name of <category id>.";
{id, ?include_first = 0} = args;
set_thread_mode(0);
handle = this.utils:open(this.database);
crumbs = include_first ? {this:category_name(id)} | {};
while (1)
  id = sqlite_execute(handle, "SELECT parent_id FROM categories WHERE id = ?;", {id})[1][1];
  if (id == "null")
    break;
  else
    crumbs = listinsert(crumbs, this:category_name(id), 1);
  endif
endwhile
return $string_utils:english_list(crumbs, "Root", " -> ", " -> ", "");
