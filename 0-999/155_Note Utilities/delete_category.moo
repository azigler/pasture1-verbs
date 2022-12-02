#155:delete_category   this none this rxd

":delete_category(INT <category ID>)";
"Delete the category <category ID>. If the folder has any notes or categories in it, E_INVARG is raised.";
{category} = args;
if (this:notes_in_category(category) != {})
  return raise(E_INVARG, "There are notes in that category.");
elseif (this:subcategories_of(category) != {})
  return raise(E_INVARG, "There are sub-categories in that category.");
endif
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "DELETE FROM categories WHERE id = ?;", {category});
