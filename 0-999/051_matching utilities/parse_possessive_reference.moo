#51:parse_possessive_reference   this none this rxd

":parse_possessive_reference(string)";
"Parses strings in a possessive format.";
"=> {STR whose, STR object}  Where 'whose' is the possessor of 'object'.";
"If the string consists only of a possessive string (ie: \"my\", or \"yduJ's\"), then 'object' will be an empty string.";
"=> 0 If the given string is not a possessive reference.";
"  Example:";
":parse_possessive_reference(\"joe's cat\") => {\"joe\", \"cat\"}";
":parse_possessive_reference(\"sis' fish\") => {\"sis\", \"fish\"}";
"  Strings are returned as a value suitable for a :match routine, thus 'my' becoming 'me'.";
":parse_possessive_reference(\"my dog\") => {\"me\", \"dog\"}";
string = args[1];
if (m = match(string, "^my$%|^my +%(.+%)?"))
  return {"me", substitute("%1", m)};
elseif (m = match(string, "^%(.+s?%)'s? *%(.+%)?"))
  return {substitute("%1", m), substitute("%2", m)};
else
  return 0;
endif
"Profane (#30788) - Sun Jun 21, 1998 - changed first parenthetical match bit from %([^ ]+s?%) to %(.+s?%)";
