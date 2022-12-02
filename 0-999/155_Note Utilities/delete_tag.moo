#155:delete_tag   this none this rxd

":delete_tag(INT id) => 0";
"Delete tag <id> completely and remove references to it from any notes.";
{tag} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "DELETE FROM tags WHERE id = ?;", {tag});
sqlite_execute(handle, "DELETE FROM note_tags WHERE tag = ?;", {tag});
