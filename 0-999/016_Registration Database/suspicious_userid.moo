#16:suspicious_userid   this none this rxd

"suspicious_userid(userid)";
"Return yes if userid is root or postmaster or something like that.";
if ($object_utils:has_property(#0, "local") && $object_utils:has_property($local, "suspicious_userids"))
  extra = $local.suspicious_userids;
else
  extra = {};
endif
return args[1] in {@$network.suspicious_userids, @extra} || match(args[1], "^guest") || match(args[1], "^help") || index(args[1], "-owner") || index(args[1], "owner-");
"Thinking about ruling out hyphenated names, on the grounds that they're probably mailing lists.";
