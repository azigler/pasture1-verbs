#45:ok_write   this none this rxd

":ok_write(caller,callerperms) => true iff caller can do write operations";
return args[1] in {this, $mail_agent} || (args[2].wizard || this:is_writable_by(args[2]));
