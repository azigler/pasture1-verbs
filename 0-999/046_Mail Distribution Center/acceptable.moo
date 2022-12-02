#46:acceptable   this none this rxd

"Only allow mailing lists/folders in here and only if their names aren't already taken.";
what = args[1];
return $object_utils:isa(what, $mail_recipient) && this:check_names(what, @what.aliases) && what:description() != parent(what):description();
