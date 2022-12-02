#45:ok_annotate   this none this rxd

":ok_annotate(caller,callerperms) => true iff caller can do annotations";
return args[1] in {this, $mail_agent} || (args[2].wizard || this:is_annotatable_by(args[2]));
