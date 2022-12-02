#103:parse_receive_args   this none this rxd

"Usage:  :parse_receive_args(msg, alist)";
"";
"Transform a messages arguments from an alist into a mostly-positional list.  The cord type has an ordered list of argument keywords for all valid messages; these are used to construct an ordered list of the items from the alist that correspond to those keywords.  If there are items in the alist that do not match a known keyword, they will be appended to the positional list with keywords attached.";
"";
"Examples:";
"  .messages_in = {{\"edit\", {\"name\", \"text\"}}}";
"  :parse_receive_args({{\"name\", \"#123.foo\"}, {\"text\", {\"Hi!\"}}})";
"    => {\"#123.foo\", \"Hi!\"}";
"  :parse_receive_args({{\"name\", \"#123.foo\"}, {\"text\", {\"Hi!\"}}, {\"type\", \"MOO-Code\"}})";
"    => {\"#123.foo\", \"Hi!\", {\"type\", \"MOO-Code\"}};";
{msg, alist} = args;
a = $list_utils:assoc(msg, this.messages_in);
if (!a)
  "this should be caught upstream.";
  raise(E_INVARG, "Invalid cord message");
endif
ret = {};
for keyword in (a[2])
  i = $list_utils:iassoc(keyword, alist);
  if (!i)
    "this too should be caught.";
    raise(E_INVARG, "Missing argument in cord message");
  endif
  ret = {@ret, alist[i][2]};
  alist = listdelete(alist, i);
endfor
return {@ret, @alist};
