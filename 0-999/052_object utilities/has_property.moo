#52:has_property   this none this rxd

"Syntax:  has_property(OBJ, STR) => INT 0|1";
"";
"Does object have the specified property? Returns true if it is defined on the object or a parent.";
{object, prop} = args;
try
  object.(prop);
  return 1;
except (E_PROPNF, E_INVIND)
  return 0;
endtry
"Old code...Ho_Yan 10/22/96";
if (prop in $code_utils.builtin_props)
  return valid(object);
else
  return !!property_info(object, prop);
endif
