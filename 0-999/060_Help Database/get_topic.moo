#60:get_topic   this none this rxd

text = pass(@args);
object = $string_utils:match_object(what = args[1], player.location);
if (text != E_PROPNF || !valid(object))
  return text;
elseif (ohelp = `object:help_msg() ! ANY' || `object.help_msg ! ANY')
  return {tostr(object.name, " (", object, "):"), "----", @typeof(ohelp) == LIST ? ohelp | {ohelp}};
else
  about = $object_utils:has_verb(object, "about");
  return {tostr("Sorry, but no help is available on ", object.name, " (", object, ")."), tostr("Try `examine ", what, "'", @about ? {" or `about ", what, "'"} | {}, ".")};
endif
