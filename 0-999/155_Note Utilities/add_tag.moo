#155:add_tag   this none this rxd

":add_tag(STR tag name[, STR tag color]) => INT tag ID";
"Add a new tag to the list of available tags, along with an optional color.";
"If the tag already exists, only the color is changed.";
{tag, ?color = 0} = args;
handle = this.utils:open(this.database);
if ((id = sqlite_execute(handle, "SELECT id FROM tags WHERE name = ?;", {tag})) != {})
  if (color == 0)
    "Nothing to update.";
    return id[1][1];
  else
    sqlite_execute(handle, "UPDATE tags SET color = ? WHERE id = ?;", {color, id[1][1]});
    return id[1][1];
  endif
else
  if (!color)
    fields = "name";
    values = "?";
    data = {tag};
  else
    fields = "name, color";
    values = "?, ?";
    data = args;
  endif
  result = sqlite_execute(handle, tostr("INSERT INTO tags(", fields, ") VALUES(", values, ");"), data);
  if (result == {})
    return sqlite_last_insert_row_id(handle);
  endif
endif
