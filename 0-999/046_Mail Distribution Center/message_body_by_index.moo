#46:message_body_by_index   this none this rxd

":message_body_by_index(i)";
"Return the body of the i-th message on the (caller) recipient.";
"i must be a message index (not a message number) in the range 1 .. number of messages,";
set_task_perms(caller_perms());
{i} = args;
msg = caller:messages_in_seq({i, i + 1})[1][2];
bstart = "" in msg;
return msg[bstart ? bstart + 1 | $ + 1..$];
