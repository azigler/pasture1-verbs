#155:add_note_to_category   this none this rxd

":add_note_to_category(INT note id, INT category ID) => 0";
"Add the note <id> to the category <id>. Since notes are pointers, one note can be placed into multiple categories. As such, this verb will make no attempt to 'move' a note.";
{note, category} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "INSERT INTO note_categories(note, category) VALUES(?, ?);", {note, category});
