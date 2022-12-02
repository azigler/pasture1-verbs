#88:set_spurned_objects   this none this rxd

"Permits programmatic setting of .spurned_objects, which is -c.";
{spurned_objects} = args;
if ($perm_utils:controls(caller_perms(), this))
  "Note, the final result must be a list of objects, otherwise there's no point.";
  if (typeof(spurned_objects) != LIST)
    spurned_objects = {spurned_objects};
  endif
  this.spurned_objects = spurned_objects;
endif
