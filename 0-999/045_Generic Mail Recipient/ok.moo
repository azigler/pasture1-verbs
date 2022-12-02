#45:ok   this none this rxd

":ok(caller,callerperms) => true iff caller can do read operations";
return args[1] in {this, $mail_agent} || (args[2].wizard || this:is_readable_by(args[2]));
