#88:find_help   this none this rxd

"'find_help (<name>[, databases])'";
"Search for a help topic with the given name. [<databases>] defaults to the ones returned by $code_utils:help_db_list().";
{name, ?databases = $code_utils:help_db_list()} = args;
if (!name)
  this:tell("What topic do you want to search for?");
elseif (result = $code_utils:help_db_search(name, databases))
  {object, realname} = result;
  if (object == $ambiguous_match)
    this:tell("The help topic \"", name, "\" could refer to any of the following:  ", $string_utils:english_list(realname));
  elseif (object == $help && !$object_utils:has_property(object, realname) && valid(o = $string_utils:match_object(name, player.location)))
    if ($object_utils:has_callable_verb(o, "help_msg"))
      this:tell("That help topic was returned by ", $string_utils:nn(o), ":help_msg().");
    elseif ($object_utils:has_property(o, "help_msg"))
      this:tell("That help topic is located in ", $string_utils:nn(o), ".help_msg.");
    else
      this:tell("That help topic was matched by $help but there doesn't seem to be any help available for it.");
    endif
  elseif (object == $help_db["verb"])
    if ((what = $code_utils:parse_verbref(realname)) && valid(what[1] = $string_utils:match_object(what[1], player.location)) && $object_utils:has_verb(@what))
      this:tell("That help topic is located at the beginning of the verb ", $string_utils:nn(what[1]), ":", what[2], ".");
    else
      this:tell("That help topic was matched by $help_db[\"verb_help\"] but there doesn't seem to be any help available for it.");
    endif
  else
    where = {};
    for x in (databases)
      if ({realname} == x:find_topics(realname))
        where = setadd(where, x);
      endif
    endfor
    asname = name == realname ? "" | " as \"" + realname + "\"";
    if (where)
      this:tell("That help topic is located on ", $string_utils:nn(where), asname, ".");
    else
      "...this shouldn't happen unless $code_utils:help_db_search finds a match we weren't expecting";
      this:tell("That help topic appears to be located on ", $string_utils:nn(object), asname, ", although this command could not find it.");
    endif
  endif
else
  this:tell("The help topic \"", name, "\" could not be found.");
endif
