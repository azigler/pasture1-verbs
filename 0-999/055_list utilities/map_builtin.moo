#55:map_builtin   this none this rxd

":map_builtin(objectlist,func) applies func to each of the objects in turn and returns the corresponding list of results.  This function is mainly here for completeness -- in the vast majority of situations, a simple for loop is better.";
set_task_perms(caller_perms());
{objs, builtin} = args;
if (!`function_info(builtin) ! E_INVARG => 0')
  return E_INVARG;
endif
if (length(objs) > 100)
  return {@this:map_builtin(objs[1..$ / 2], builtin), @this:map_builtin(objs[$ / 2 + 1..$], builtin)};
endif
strs = {};
for foo in (objs)
  strs = {@strs, call_function(builtin, foo)};
endfor
return strs;
