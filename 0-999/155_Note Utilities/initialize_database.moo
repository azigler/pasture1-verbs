#155:initialize_database   this none this rxd

":initialize_database() => 0";
"Create the initial tables for the database. NOTE: This should only be done once...";
handle = this.utils:open(this.database, 8 |. 2 |. 4);
sqlite_query(handle, "BEGIN TRANSACTION;");
sqlite_query(handle, "CREATE TABLE categories( id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL, parent_id INTEGER)");
sqlite_query(handle, "CREATE TABLE note_categories( id INTEGER PRIMARY KEY NOT NULL, note INTEGER NOT NULL, category INTEGER NOT NULL)");
sqlite_query(handle, "CREATE TABLE note_tags( id INTEGER PRIMARY KEY NOT NULL, note INTEGER NOT NULL, tag INTEGER NOT NULL)");
sqlite_query(handle, "CREATE VIRTUAL TABLE notes using fts5(title, body)");
sqlite_query(handle, "CREATE TABLE note_metadata( note INTEGER PRIMARY KEY NOT NULL, author TEXT, author_objnum TEXT, created INT, modified INT)");
sqlite_query(handle, "CREATE TABLE tags( id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL, color text)");
sqlite_query(handle, "INSERT INTO categories(name, parent_id) VALUES( 'Root', NULL);");
sqlite_query(handle, "COMMIT;");
