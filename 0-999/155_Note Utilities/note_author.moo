#155:note_author   this none this rxd

":note_author(INT <note ID>) => LIST";
"Return a list containing the plaintext author name at the time of writing and the object number of the author.";
"If no author information is available, E_INVARG is raised.";
{note} = args;
handle = this.utils:open(this.database);
results = sqlite_execute(handle, "SELECT author, author_objnum FROM note_metadata WHERE note=?;", {note});
if (results == {})
  return raise(E_INVARG, tostr("No author found for note ", note), note);
else
  return results[1];
endif
