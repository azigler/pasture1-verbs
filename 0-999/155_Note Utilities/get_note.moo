#155:get_note   this none this rxd

":get_note(INT id) => LIST";
"Return a list of {title, body} for the given note <id>.";
"If such a note doesn't exist, E_INVARG is raised.";
{note} = args;
handle = this.utils:open(this.database);
data = sqlite_execute(handle, "SELECT title, body FROM notes WHERE rowid = ?;", {note});
if (data == {})
  return raise(E_INVARG, "Note ID not found");
else
  return {data[1][1], $no_one:eval(data[1][2])[2]};
endif
