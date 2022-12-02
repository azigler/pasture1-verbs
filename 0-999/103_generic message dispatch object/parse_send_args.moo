#103:parse_send_args   this none this rxd

"Usage:  :parse_send_args(msg, @posargs, @keywordargs)";
"";
"Transform a given message's arguments (mostly given positionally) into the correct form for MCP.  The cord type has an ordered list of argument keywords for all valid messages; these are matched with the arguments provided to produce an alist.  If more arguments are provided than keywords are available, then the remaining arguments should be {keyword, value} pairs.  This allows the passing of optional arguments and such.";
"";
"This verb returns an alist suitable for use with :client_notify().";
"";
"Examples:";
"  .messages_out = {{\"edit\", {\"name\", \"text\"}}}";
"  :parse_send_args(\"edit\", \"#123.foo\", {\"This is the first line.\"})";
"    => {{\"name\", \"#123.foo\"}, {\"text\", {\"This is the first line.\"}}}";
"  :parse_send_args(\"edit\", \"#123:foo\", {\"Hi!\"}, {\"type\", \"MOO-Code\"})";
"    => {{\"name\", \"#123.foo\"}, {\"text\", {\"Hi!\"}}, {\"type\", \"MOO-Code\"}}";
{msg, @rest} = args;
a = $list_utils:assoc(msg, this.messages_out);
if (!a)
  raise(E_INVARG, "Invalid message");
endif
keywords = a[2];
lkeywords = length(keywords);
lrest = length(rest);
if (lrest < lkeywords)
  raise(E_ARGS, "Incorrect number of message arguments");
endif
return {@$list_utils:make_alist({keywords, rest[1..lkeywords]}), @rest[lkeywords + 1..$]};
