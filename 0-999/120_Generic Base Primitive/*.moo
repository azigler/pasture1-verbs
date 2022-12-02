#120:*   this none this rxd

"Created 02/01/19 1:40 p.m. by Sinistral (#2) on ChatMUD";
"Last ditch attempt to do something useful...";
set_task_perms(caller_perms());
if (verb in {"init_for_core", "include_for_core", "proxy_for_core"})
  return {};
elseif (this in {$failed_match, $ambiguous_match, $nothing})
  return this;
endif
return call_function(verb, this, @args);
