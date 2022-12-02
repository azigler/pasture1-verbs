#155:add_category   this none this rxd

":add_category(INT parent ID, STR name) => INT category ID";
"Add the category named <name> with the parent <parent>.";
{parent, name} = args;
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "INSERT INTO categories(name, parent_id) VALUES (?, ?);", {name, parent});
if (result == {})
  return sqlite_last_insert_row_id(handle);
endif
