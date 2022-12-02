#76:check_verb_args   this none this rxd

value = args[1];
if (typeof(value) != LIST)
  return "List expected";
elseif (length(value) != 3)
  return "List of length 3 expected";
elseif (!(value[1] in {"this", "none", "any"}))
  return tostr("Invalid dobj specification:  ", value[1]);
elseif (!((p = $code_utils:short_prep(value[2])) || value[2] in {"none", "any"}))
  return tostr("Invalid preposition:  ", value[2]);
elseif (!(value[3] in {"this", "none", "any"}))
  return tostr("Invalid iobj specification:  ", value[3]);
else
  if (p)
    value[2] = p;
  endif
  return {value};
endif
