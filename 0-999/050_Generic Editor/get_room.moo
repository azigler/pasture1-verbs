#50:get_room   this none this rxd

":get_room([player])  => correct room to match in on invocation.";
{?who = player} = args;
if (who.location != this)
  return who.location;
else
  origin = this;
  while ((where = player in origin.active) && (valid(origin = origin.original[where]) && origin != this))
    if (!$object_utils:isa(origin, $generic_editor))
      return origin;
    endif
  endwhile
  return this;
endif
