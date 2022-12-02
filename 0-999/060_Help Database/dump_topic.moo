#60:dump_topic   this none this rxd

if ((text = pass(@args)) != E_PROPNF || (!valid(object = $string_utils:match_object(what = args[1], player.location)) || !$object_utils:has_property(object, "help_msg")))
  return text;
else
  return {tostr(";;", $code_utils:corify_object(object), ".help_msg = $command_utils:read_lines()"), @$command_utils:dump_lines(typeof(text = object.help_msg) == LIST ? text | {text})};
endif
