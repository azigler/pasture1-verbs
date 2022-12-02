#30:objectdoc   this none this rxd

"{\"*objectdoc*\", \"object\"} => text for topic from object:help_msg";
if (!valid(object = $string_utils:literal_object(args[1][1])))
  return E_INVARG;
elseif (!($object_utils:has_verb(object, "help_msg") || $object_utils:has_property(object, "help_msg")))
  return E_VERBNF;
else
  return $code_utils:verb_or_property(object, "help_msg");
endif
