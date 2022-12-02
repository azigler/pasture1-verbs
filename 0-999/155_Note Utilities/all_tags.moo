#155:all_tags   this none this rxd

":all_tags() => LIST";
"Return a list of all tag IDs.";
handle = this.utils:open(this.database);
return slice(sqlite_query(handle, "SELECT id FROM tags;"), 1);
