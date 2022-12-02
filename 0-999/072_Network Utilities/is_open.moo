#72:is_open   this none this rxd

":is_open(object)";
"return true if the object is somehow connected, false otherwise.";
return typeof(`idle_seconds(@args) ! ANY') == INT;
"Relies on test in idle_seconds, and the error catching";
