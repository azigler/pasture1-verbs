#46:set_message_body_by_index   this none this rxd

":set_message_body_by_index(i,newbody)";
"Replaces the body of the i-th message on the (caller) recipient.";
"i must be a message index (not a message number) in the range 1 .. number of messages,";
"newbody must be a list of strings.";
set_task_perms(caller_perms());
{i, body} = args;
bstart = "" in caller.messages[i][2];
if (bstart)
  caller.messages[i][2][bstart + 1..$] = body;
else
  caller.messages[i][2][$ + 1..$] = {"", @body};
endif
