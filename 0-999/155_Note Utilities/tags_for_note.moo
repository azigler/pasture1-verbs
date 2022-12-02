#155:tags_for_note   this none this rxd

":tags_for_note(INT <id>) => LIST";
"Return a list of tag IDs associated with the note <id>.";
{note} = args;
handle = this.utils:open(this.database);
return slice(sqlite_execute(handle, "SELECT tag FROM note_tags WHERE note = ?;", {note}), 1);
