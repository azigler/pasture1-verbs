#113:edit_set_program   this none this rxd

{reference, lines} = args;
set_task_perms(caller_perms());
args = $string_utils:words(reference);
punt = 1;
if (!(spec = $code_utils:parse_verbref(args[1])))
  raise(E_INVARG, "Invalid reference: " + reference);
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  return;
elseif ($string_utils:is_numeric(spec[2]))
  "numeric verbref";
  if ((verbname = $code_utils:tonum(spec[2])) == E_TYPE)
    raise(E_INVARG, "Invalid verb number");
  elseif (length(args) > 1)
    raise(E_INVARG, "Invalid reference: " + reference);
  elseif (verbname < 1 || `verbname > length(verbs(object)) ! E_PERM => 0')
    raise(E_INVARG, "Verb number out of range.");
  else
    argspec = 0;
    punt = 0;
  endif
elseif (typeof(argspec = $code_utils:parse_argspec(@listdelete(args, 1))) != LIST)
  raise(E_INVARG, tostr(argspec));
elseif (argspec[2])
  raise(E_INVARG, $string_utils:from_list(argspec[2], " ") + "??");
elseif (length(argspec = argspec[1]) in {1, 2})
  raise(E_INVARG, {"Missing preposition", "Missing iobj specification"}[length(argspec)]);
else
  punt = 0;
  verbname = spec[2];
  if (index(verbname, "*") > 1)
    verbname = strsub(verbname, "*", "");
  endif
endif
"...";
"...if we have an argspec, we'll need to reset verbname...";
"...";
if (punt)
elseif (argspec)
  named = argspec[4..min(5, $)];
  argspec = argspec[1..3];
  if (!(argspec[2] in {"none", "any"}))
    argspec[2] = $code_utils:full_prep(argspec[2]);
  endif
  loc = $code_utils:find_verb_named_1_based(object, verbname);
  while (loc && `verb_args(object, loc) ! E_PERM' != argspec)
    loc = $code_utils:find_verb_named_1_based(object, verbname, loc + 1);
  endwhile
  if (loc)
    verbname = loc;
  else
    punt = "...can't find it....";
    raise(E_INVARG, "That object has no verb matching that name + args.");
  endif
else
  named = {};
  loc = typeof(verbname) == NUM ? verbname | 0;
endif
if (!punt)
  try
    info = verb_info(object, verbname);
  except e (ANY)
    if (e[1] == E_VERBNF)
      raise(E_INVARG, "That object does not have that verb definition.");
    else
      raise(E_INVARG, tostr(e[2]));
    endif
    punt = 1;
  endtry
  if (!punt)
    aliases = info[3];
    if (!loc)
      loc = aliases in (verbs(object) || {});
    endif
  endif
endif
if (punt)
  return;
else
  "filter the verb?";
  if (this.v_filter_in)
    lines = this.v_filter_in[1]:(this.v_filter_in[2])(lines);
  endif
  if (0 && named)
    "Disabled: We want to see all of the code in the verb and not in the title.";
    code = $code_utils:split_verb_code(lines);
    lines = {@code[1], @$code_utils:named_args_to_code(named), @code[2]};
  endif
  try
    result = set_verb_code(object, verbname, lines);
  except e (ANY)
    result = e[2] + " ";
    "just in case some idiot throws an error with an empty string";
  endtry
  what = $string_utils:nn(object);
  if (result)
    if (typeof(result) == STR)
      return {"Error programming " + what, result, "Verb not programmed."};
    else
      return {"Error programming " + what, @result, tostr(length(result), " error(s)."), "Verb not programmed."};
    endif
  else
    return {"0 errors.", "Verb programmed."};
  endif
endif
