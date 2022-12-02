#79:recent_object_bytes   this none this rxd

":recent_object_bytes(x, n) -- return object size of x, guaranteed to be no more than n days old.  N defaults to this.cycle_days.";
{object, ?since = this.cycle_days} = args;
if (!valid(object))
  return 0;
elseif (`object.object_size[2] ! ANY => 0' > time() - since * 24 * 60 * 60)
  "Trap error when doesn't have .object_size for some oddball reason. Ho_Yan 11/19/96";
  return object.object_size[1];
else
  return this:object_bytes(object);
endif
