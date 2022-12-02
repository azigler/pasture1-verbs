#155:subcategories_of   this none this rxd

":subcategories_of(INT id[, INT include name) => LIST";
"Return a list of IDs of categories with <id> as their parent. If include name is true, the returned list will include the ID and the name.";
{id, ?include_name = 0} = args;
handle = this.utils:open(this.database);
select = include_name ? "id, name" | "id";
data = sqlite_execute(handle, tostr("SELECT ", select, " FROM categories WHERE parent_id = ?;"), {id});
if (!include_name)
  return slice(data);
else
  return data;
endif
