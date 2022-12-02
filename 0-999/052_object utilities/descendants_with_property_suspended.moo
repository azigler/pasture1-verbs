#52:descendants_with_property_suspended   this none this rxd

":descendants_with_property_suspended(object,property)";
" => list of descendants of object on which property is defined.";
"calls suspend(0) as needed";
{object, prop} = args;
if (caller == this || (object.w || $perm_utils:controls(caller_perms(), object)))
  $command_utils:suspend_if_needed(0);
  if (`property_info(object, prop) ! E_PROPNF => 0')
    return {object};
  endif
  r = {};
  for c in (children(object))
    r = {@r, @this:descendants_with_property_suspended(c, prop)};
  endfor
  return r;
else
  return E_PERM;
endif
