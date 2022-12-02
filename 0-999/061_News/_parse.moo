#61:_parse   this none this rxd

if (!(strings = args[1]))
  return "You need to specify a message sequence";
elseif (typeof(pms = this:parse_message_seq(@args)) == STR)
  return $string_utils:substitute(pms, {{"%f", "The news"}, {"%<has>", "has"}, {"%%", "%"}});
elseif (typeof(pms) != LIST)
  return tostr(pms);
elseif (length(pms) > 1)
  return tostr("I don't understand `", pms[2], "'.");
elseif (!(seq = pms[1]))
  return tostr("The News (", this, ") has no `", $string_utils:from_list(strings, " "), "' messages.");
else
  return seq;
endif
