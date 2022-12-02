#155:note_name   this none this rxd

":note_name(INT id) => STR";
"Return the title of note <id>";
"If such a note doesn't exist, E_INVARG is raised.";
{note} = args;
set_thread_mode(0);
handle = this.utils:open(this.database);
data = sqlite_execute(handle, "SELECT title FROM notes WHERE rowid = ?;", {note});
if (data == {})
  return raise(E_INVARG, tostr("Note ID ", note, " not found"));
else
  return tostr(data[1][1]);
endif
