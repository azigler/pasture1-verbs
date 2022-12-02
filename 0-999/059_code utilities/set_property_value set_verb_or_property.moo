#59:"set_property_value set_verb_or_property"   this none this rx

":set_property_value(object, property, value)";
" set_verb_or_property(same) -- similar to `verb_or_property'";
"  -- attempts to set <object>.<property> to <value>.  If there exists <object>:set_<property>, then it is called and its returned value is returned.  If not, we try to set the property directly; the result of this is returned.";
set_task_perms(caller_perms());
if (length(args) != 3)
  return E_ARGS;
elseif (typeof(o = args[1]) != OBJ)
  return E_INVARG;
elseif (!$recycler:valid(o))
  return E_INVIND;
elseif (typeof(p = args[2]) != STR)
  return E_INVARG;
elseif ($object_utils:has_callable_verb(o, v = "set_" + p))
  return o:(v)(args[3]);
else
  return o.(p) = args[3];
endif
