#37:count   any (in/inside/into) this rd

"count [entries|chars] in <db>";
"  reports on the number of distinct string keys or the number of characters";
"  in all string keys in the db";
if (index("entries", dobjstr) == 1)
  player:tell(this:count_entries("", 0), " strings in ", this.name, "(", this, ")");
elseif (index("chars", dobjstr) == 1)
  player:tell(this:count_chars("", 0), " chars in ", this.name, "(", this, ")");
else
  player:tell("Usage: ", verb, " entries|chars in <db>");
endif
