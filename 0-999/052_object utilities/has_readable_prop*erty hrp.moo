#52:"has_readable_prop*erty hrp"   this none this rxd

":has_readable_property(OBJ object, STR property name) => 1 if property exists and is publically readable (has the r flag set true).";
{object, prop} = args;
try
  pinfo = property_info(object, prop);
  return index(pinfo[2], "r") != 0;
except (E_PROPNF)
  return prop in $code_utils.builtin_props > 0;
endtry
