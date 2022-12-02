#18:get_topic   this none this rxd

"Help facility for verbs that people have bothered to document.  If the argument is a verb specification, this retrieves the code and prints any documentation lines that might be at the beginning.  Returns true if the arg can actually be interpreted as a verb specification, whether or not it is a correct one.";
set_task_perms(caller_perms());
if (!(spec = $code_utils:parse_verbref(args[1])))
  return 0;
elseif ($command_utils:object_match_failed(object = $string_utils:match_object(spec[1], player.location), spec[1]))
  return 1;
elseif (!(hv = $object_utils:has_verb(object, spec[2])))
  return "That object does not define that verb.";
elseif (typeof(verbdoc = $code_utils:verb_documentation(object = hv[1], spec[2])) == ERR)
  return tostr(verbdoc);
elseif (typeof(info = `verb_info(object, spec[2]) ! ANY') == ERR)
  return tostr(info);
else
  objverb = tostr(object.name, "(", object, "):", strsub(info[3], " ", "/"));
  if (verbdoc)
    return {tostr("Information about ", objverb), "----", @verbdoc};
  else
    return tostr("No information about ", objverb);
  endif
endif
