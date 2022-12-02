#55:map_verb   this none this rxd

set_task_perms(caller_perms());
{objs, vrb, @rest} = args;
if (length(objs) > 50)
  return {@this:map_verb(@listset(args, objs[1..$ / 2], 1)), @this:map_verb(@listset(args, objs[$ / 2 + 1..$], 1))};
endif
strs = {};
for o in (objs)
  strs = {@strs, o:(vrb)(@rest)};
endfor
return strs;
