#155:add_tag_to_note   this none this rxd

":add_tag_to_note(INT <tag id>, INT <note id>) => 0";
"Associate the tag specified by <tag id> with the note specified by <note id>.";
{tag, note} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "INSERT INTO note_tags(note, tag) VALUES(?, ?);", {note, tag});
