#88:property_inherited_from   this none this rxd

"'property_inherited_from (<object>, <property name>)' -> object - Return the ancestor of <object> on which <object>.<property> is originally defined. If <object>.<property> is not actually defined, return 0. The property is taken as originally defined on the earliest ancestor of <object> which has it. If the property is built-in, return $nothing.";
{what, prop} = args;
if (!$object_utils:has_property(what, prop))
  return 0;
elseif (prop in $code_utils.builtin_props)
  return $nothing;
endif
ancestor = what;
while ($object_utils:has_property(parent(ancestor), prop))
  ancestor = parent(ancestor);
endwhile
return ancestor;
