#155:set_note_text   this none this rxd

":set_note_text(INT <note ID>, LIST <text>)";
"Sets the text of <note ID> to <text>.";
{id, text} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "UPDATE notes SET body = ? WHERE rowid = ?;", {toliteral(text), id});
