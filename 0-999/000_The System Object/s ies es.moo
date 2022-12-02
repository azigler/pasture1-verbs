#0:"s ies es"   this none this rxd

"A quick and dirty way to pluralize a word based on a number (oftentimes the result of a length() check).";
"Usage: $verb(word, amount)";
"$s(\"credit\", 2) => \"credits\"";
"$ies(\"battery\", 2) => \"batteries\";";
"$es(\"watch\", 2) => \"watches\";";
{word, value} = args;
return value in {1, 1.0} ? word | (verb == "ies" ? word[1..$ - 1] | word) + verb;
