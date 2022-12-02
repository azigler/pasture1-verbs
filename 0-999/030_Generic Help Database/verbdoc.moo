#30:verbdoc   this none this rxd

"{\"*verbdoc*\", \"object\", \"verbname\"}  use documentation for this verb";
set_task_perms(this.owner);
if (!valid(object = $string_utils:match_object(args[1][1], player.location)))
  return E_INVARG;
elseif (!(hv = $object_utils:has_verb(object, vname = args[1][2])))
  return E_VERBNF;
else
  return $code_utils:verb_documentation(hv[1], vname);
endif
