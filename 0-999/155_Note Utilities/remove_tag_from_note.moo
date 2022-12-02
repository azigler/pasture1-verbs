#155:remove_tag_from_note   this none this rxd

":remove_tag_from_note(INT <tag id>, INT <note id>) => 0";
"Remove the association of <tag id> from <note id>.";
{tag, note} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "DELETE FROM note_tags WHERE note = ? AND tag = ?';", {note, tag});
