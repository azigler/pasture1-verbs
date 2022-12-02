#99:quote_ansi   this none this rxd

":quote_ansi (STR string) => STR new_string";
"Puts a [[null]null] code in the middle of all of the other codes in <string>";
"so they won't be replaced.";
return strsub(args[1], "[", "[[null]");
"...should probably only fix real codes, but this works for now...";
