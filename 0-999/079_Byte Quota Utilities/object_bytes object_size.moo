#79:"object_bytes object_size"   this none this rxd

"No need for lengthy algorithms to measure an object, we have a builtin now. Ho_Yan 10/31/96";
set_task_perms($wiz_utils:random_wizard());
o = args[1];
if ($object_utils:has_property(o, "object_size") && o.object_size[1] > this.too_large && !caller_perms().wizard && caller_perms() != this.owner && caller_perms() != $hacker)
  return o.object_size[1];
endif
b = object_bytes(o);
if ($object_utils:has_property(o, "object_size"))
  oldsize = is_clear_property(o, "object_size") ? 0 | o.object_size[1];
  if ($object_utils:has_property(o.owner, "size_quota"))
    "Update quota cache.";
    if (oldsize)
      o.owner.size_quota[2] = o.owner.size_quota[2] + (b - oldsize);
    else
      o.owner.size_quota[2] = o.owner.size_quota[2] + b;
      if (o.owner.size_quota[4] > 0)
        o.owner.size_quota[4] = o.owner.size_quota[4] - 1;
      endif
    endif
  endif
  o.object_size = {b, time()};
endif
if (b > this.too_large)
  this.large_objects = setadd(this.large_objects, o);
endif
return b;
