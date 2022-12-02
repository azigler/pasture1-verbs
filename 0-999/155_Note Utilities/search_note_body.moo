#155:search_note_body   this none this rxd

":search_note_body(STR <search>) => LIST";
"Return a list of note IDs that contain <search> in the body.";
{search} = args;
handle = this.utils:open(this.database);
return slice(sqlite_execute(handle, "SELECT rowid FROM notes WHERE body MATCH ?;", {search}), 1);
