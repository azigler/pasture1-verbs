#18:dump_topic   this none this rxd

set_task_perms(caller_perms());
if (!(spec = $code_utils:parse_verbref(args[1])))
  return E_INVARG;
elseif ($command_utils:object_match_failed(object = $string_utils:match_object(spec[1], player.location), spec[1]))
  return E_INVARG;
elseif (!(hv = $object_utils:has_verb(object, spec[2])))
  return E_VERBNF;
elseif (typeof(vd = $code_utils:verb_documentation(hv[1], spec[2])) != LIST)
  return vd;
else
  return {tostr(";$code_utils:set_verb_documentation(", $code_utils:corify_object(hv[1]), ",", $string_utils:print(spec[2]), ",$command_utils:read_lines())"), @$command_utils:dump_lines(vd)};
endif
