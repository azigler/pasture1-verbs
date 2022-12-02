#55:map_prop*erty   this none this rxd

set_task_perms(caller_perms());
{objs, prop} = args;
if (length(objs) > 50)
  return {@this:map_prop(objs[1..$ / 2], prop), @this:map_prop(objs[$ / 2 + 1..$], prop)};
endif
strs = {};
for foo in (objs)
  strs = {@strs, foo.(prop)};
endfor
return strs;
