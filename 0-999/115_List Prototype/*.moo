#115:*   this none this rxd

set_task_perms(player);
"Don't respond to calls from built-ins";
{_, name, programmer, location, _} = callers()[1];
if (name && programmer == $nothing && location == $nothing)
  return;
endif
"Exceptions";
if (verb in {"init_for_core", "exitfunc", "enterfunc", "moveto"})
  return `pass(@args) ! ANY => 0';
elseif (verb in {"from_list", "english_list", "title_list", "generate_symmetrical_columns"})
  return $string_utils:(verb)(this, @args);
elseif (verb == "include_for_core")
  return {};
elseif ($object_utils:has_callable_verb($list_utils, verb))
  return $list_utils:(verb)(this, @args);
elseif (verb == "len")
  return length(this, @args);
endif
"Frobs, originally conceptualized by Todd Sundsted for Improvise.";
if (this && `prototype = this[1] ! E_RANGE' in $frobs)
  return prototype:(verb)(@args);
endif
return pass(@args);
