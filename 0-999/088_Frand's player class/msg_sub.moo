#88:msg_sub   this none this rxd

"Do pronoun and other substitutions on the teleport messages. The arguments are: 1. The original message, before any substitutions; 2. object being teleported; 3. from location; 4. to location. The return value is the final message.";
{msg, thing, from, to} = args;
msg = $string_utils:substitute(msg, $string_utils:pronoun_quote({{"%<from room>", valid(from) ? from.name | "Nowhere"}, {"%<to room>", valid(to) ? to.name | "Nowhere"}}));
msg = $string_utils:pronoun_sub(msg, thing);
return msg;
