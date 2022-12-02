#155:category_name   this none this rxd

":category_name(INT id) => STR";
"Return the English name of the category specified by <id>";
{id} = args;
handle = this.utils:open(this.database);
result = sqlite_execute(handle, "SELECT name FROM categories WHERE id=?;", {id});
return result == {} ? raise(E_NONE, "Category ID not found") | tostr(result[1][1]);
