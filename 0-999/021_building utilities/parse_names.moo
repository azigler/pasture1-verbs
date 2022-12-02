#21:parse_names   this none this rxd

"$building_utils:parse_names(spec)";
"Return {name, {alias, alias, ...}} from name,alias,alias or name:alias,alias";
spec = args[1];
if (!(colon = index(spec, ":")))
  aliases = $string_utils:explode(spec, ",");
  if (!aliases)
    aliases = {spec};
  endif
  name = aliases[1];
else
  aliases = $string_utils:explode(spec[colon + 1..$], ",");
  name = spec[1..colon - 1];
endif
return {name, $list_utils:map_arg($string_utils, "trim", aliases)};
