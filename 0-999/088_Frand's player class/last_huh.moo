#88:last_huh   this none this rxd

set_task_perms(caller_perms());
if (pass(@args))
  return 1;
endif
{verb, args} = args;
if (valid(dobj = $string_utils:literal_object(dobjstr)) && (r = $match_utils:match_verb(verb, dobj, args)))
  return r;
elseif (valid(iobj = $string_utils:literal_object(iobjstr)) && (r = $match_utils:match_verb(verb, iobj, args)))
  return r;
else
  return 0;
endif
