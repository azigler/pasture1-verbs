#155:notes_in_category   this none this rxd

":notes_in_category(INT category id) => LIST";
"Return a list of all the note IDs filed in <category ID>";
{category} = args;
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "SELECT note FROM note_categories WHERE category = ?;", {category});
return slice(result, 1);
