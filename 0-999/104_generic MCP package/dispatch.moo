#104:dispatch   this none this rxd

"Usage:  :dispatch_request(who, authkey, name, arguments)";
"";
connection = caller;
{message, alist} = args;
if (verbname = this:message_name_to_verbname(message))
  set_task_perms(caller_perms());
  this:(verbname)(connection, @this:parse_receive_args(message, alist));
endif
