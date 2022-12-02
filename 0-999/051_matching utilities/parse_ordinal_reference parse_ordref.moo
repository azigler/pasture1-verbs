#51:"parse_ordinal_reference parse_ordref"   this none this rxd

":parse_ordref(string)";
"Parses strings referring to an 'nth' object.";
"=> {INT n, STR object} Where 'n' is the number the ordinal represents, and 'object' is the rest of the string.";
"=> 0 If the given string is not an ordinal reference.";
"  Example:";
":parse_ordref(\"second broadsword\") => {2, \"broadsword\"}";
":parse_ordref(\"second\") => 0";
"  Note that there must be more to the string than the ordinal alone.";
if (m = match(args[1], "^" + this.ordinal_regexp + " +%([^ ].+%)$"))
  o = substitute("%1", m);
  n = o in this.ordn || o in this.ordw;
  return n && {n, substitute("%2", m)};
else
  return 0;
endif
