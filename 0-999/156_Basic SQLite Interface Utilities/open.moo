#156:open   this none this rxd

":open(STR <database name>[, INT <options>])";
"Return an SQLite handle for the given database name.";
{database, ?bitmask = 0} = args;
path = this:build_path(database);
handle = `this.open[path] ! E_RANGE';
if (handle != E_RANGE && handle in sqlite_handles() && sqlite_info(handle)["path"] == tostr(this.ignored_path, path))
  return handle;
else
  to_pass = bitmask ? {path, bitmask} | {path};
  handle = sqlite_open(@to_pass);
  this.open[path] = handle;
  after_connect = `this.after_connect_commands[path] ! E_RANGE';
  if (after_connect != E_RANGE)
    for x in (after_connect)
      sqlite_query(handle, x);
    endfor
  endif
  return handle;
endif
