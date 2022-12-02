#155:add_note   this none this rxd

":add_note(STR title, LIST body) => INT";
"Adds a new note. This does NOT add it to any categories or add any tags.";
"Returns the ID of the newly added note.";
{title, body, ?who = player} = args;
if (!caller_perms().wizard && who != player)
  who = player;
endif
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "INSERT INTO notes(title, body) VALUES(?, ?);", {title, toliteral(body)});
if (result == {})
  note_id = sqlite_last_insert_row_id(handle);
else
  raise(E_INVARG, "Note creation failed.");
endif
sqlite_execute(handle, "INSERT INTO note_metadata(note, author, author_objnum, created, modified) VALUES(?, ?, ?, strftime('%s','now'), strftime('%s','now'));", {note_id, who:title(), toliteral(who)});
return note_id;
