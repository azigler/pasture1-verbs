#155:"get_note_title get_note_name"   this none this rxd

":get_note_title(INT <id>) => STR";
"Return the title of the note <id>. If no such note exists, E_INVARG is raised.";
{note} = args;
set_thread_mode(0);
handle = this.utils:open(this.database);
data = sqlite_execute(handle, "SELECT title FROM notes WHERE rowid= ?;", {note});
if (data == {})
  return raise(E_INVARG, "Note ID not found");
else
  return data[1][1];
endif
