#155:remove_note_from_category   this none this rxd

":remove_note_from_category(INT note id, INT category ID) => 0";
"Remove the note <note id> from the category <category id>.";
{note, category} = args;
handle = this.utils:open(this.database);
sqlite_execute(handle, "DELETE FROM note_categories WHERE note = ? AND category = ?;", {note, category});
