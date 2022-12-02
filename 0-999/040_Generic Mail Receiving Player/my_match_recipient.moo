#40:my_match_recipient   this none this rxd

":my_match_recipient(string) => matches string against player's private mailing lists.";
if (!(string = args[1]))
  return $nothing;
elseif (string[1] == "*")
  string = string[2..$];
endif
return $string_utils:match(string, this.mail_lists, "aliases");
