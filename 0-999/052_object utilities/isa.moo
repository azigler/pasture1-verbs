#52:isa   this none this rxd

{what, targ, ?return_parent = 0} = args;
if (typeof(what) == OBJ && typeof(targ) in {OBJ, LIST})
  return isa(@args);
elseif (typeof(what) == WAIF && typeof(targ) in {OBJ, LIST})
  return isa(what.class, targ, return_parent);
elseif (typeof(what) == WAIF && typeof(targ) == WAIF)
  return isa(what.class, targ.class, return_parent);
elseif (typeof(what) == OBJ && typeof(targ) == WAIF)
  return isa(targ.class, what, return_parent);
else
  raise(E_INVARG);
endif
