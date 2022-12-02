#20:pronoun_sub_secure   this none this rxd

"$string_utils:pronoun_sub_secure(string[,who[,thing[,location]]], default)";
"Do pronoun_sub on string with the arguments given (see help";
"string_utils:pronoun_sub for more information).  Return pronoun_subbed";
"<default> if the subbed string does not contain <who>.name (<who>";
"defaults to player).";
who = length(args) > 2 ? args[2] | player;
default = args[$];
result = this:pronoun_sub(@args[1..$ - 1]);
return this:index_delimited(result, who.name) ? result | this:pronoun_sub(@{default, @args[2..$ - 1]});
