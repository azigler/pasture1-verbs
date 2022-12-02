#117:*   this none this rxd

"This catches everything else that doesn't have a specific function.";
set_task_perms(caller_perms());
"don't respond to calls from built-ins";
{_, name, programmer, location, _} = callers()[1];
if (name && programmer == $nothing && location == $nothing)
  return;
endif
"Frobs, originally conceptualized by Todd Sundsted for Improvise.";
if (this && `prototype = this[$map_proto.frob_key_name] ! E_RANGE' in $frobs)
  return prototype:(verb)(@args);
endif
return pass(@args);
