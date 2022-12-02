#155:note_metadata   this none this rxd

":note_metadata(note) => LIST";
"Return the complete metadata for a note.";
"Values: {author, author object number, creation time, modification time}";
"If no metadata is found, E_INVARG is raised with the note as the value.";
{note} = args;
handle = this.utils:open(this.database);
results = sqlite_execute(handle, "SELECT * FROM note_metadata WHERE note=?;", {note});
if (results == {})
  return raise(E_INVARG, tostr("No metadata found for note ", note), note);
else
  return results[1][2..$];
endif
