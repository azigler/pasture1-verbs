#155:find_tag_by_name   this none this rxd

":find_tag_by_name(STR <tag name>) => INT";
"Attempts to identify a tag by name. If the tag isn't found, $failed_match is returned.";
{name} = args;
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "SELECT id FROM tags WHERE name = ?;", {name});
return result == {} ? $failed_match | result[1][1];
