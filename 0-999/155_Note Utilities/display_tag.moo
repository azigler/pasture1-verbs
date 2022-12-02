#155:display_tag   this none this rxd

":display_tag(INT id) => STR";
"Returns the name of a tag. If color is specified, the appropriate color is applied.";
"If the tag doesn't exist, E_INVARG is raised.";
{id} = args;
handle = this.utils:open(this.database);
tag = sqlite_execute(handle, "SELECT name, color FROM tags WHERE id=?;", {id});
if (tag == {})
  return raise(E_INVARG, "Invalid tag");
else
  {name, color} = tag[1];
  return color == "NULL" ? name | tostr($ansi_utils:hr_to_code(color), name, "[normal]");
endif
