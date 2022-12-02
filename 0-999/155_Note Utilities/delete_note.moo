#155:delete_note   this none this rxd

":delete_note(INT id) => 0";
"Permanently delete a note.";
{id} = args;
handle = this.utils:open(this.database);
sqlite_query(handle, "BEGIN TRANSACTION;");
sqlite_execute(handle, "DELETE FROM note_categories WHERE note = ?;", {id});
sqlite_execute(handle, "DELETE FROM notes WHERE rowid = ?;", {id});
sqlite_query(handle, "COMMIT;");
