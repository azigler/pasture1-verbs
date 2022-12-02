#155:category_for   this none this rxd

":category_for(INT <note ID>)";
"Return a list of all categories <note ID> is in.";
{note} = args;
handle = this.utils:open(this.database);
return $list_utils:flatten(sqlite_execute(handle, "SELECT category FROM note_categories WHERE note = ?;", {note}));
