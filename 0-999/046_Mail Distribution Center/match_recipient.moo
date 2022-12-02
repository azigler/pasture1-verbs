#46:match_recipient   this none this rxd

":match_recipient(string[,meobj]) => $player or $mail_recipient object that matches string.  Optional second argument (defaults to player) is returned in the case string==\"me\" and is also used to obtain a list of private $mail_recipients to match against.";
{string, ?me = player} = args;
if (valid(me) && $failed_match != (o = me:my_match_recipient(string)))
  return o;
elseif (!string)
  return $nothing;
elseif (string[1] == "*" && string != "*")
  return this:match(@args);
elseif (string[1] == "`")
  args[1][1..1] = "";
  return $string_utils:match_player(@args);
elseif (valid(o = $string_utils:match_player(@args)) || o == $ambiguous_match)
  return o;
else
  return this:match(@args);
endif
