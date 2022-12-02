#79:property_overhead_bytes   this none this rxd

{o, ?ps = $object_utils:all_properties_suspended(o)} = args;
return value_bytes(properties(o)) - 4 + length(ps) * 4 * 4;
