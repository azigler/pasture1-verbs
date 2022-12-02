#156:build_path   this none this rxd

":build_path([STR <database name>])";
"Return the filesystem path for databases.";
"If <database name> is provided, it will be appended to the end of the path.";
{?database = 0} = args;
return tostr(this.path, database != 0 ? "/" + database | "");
