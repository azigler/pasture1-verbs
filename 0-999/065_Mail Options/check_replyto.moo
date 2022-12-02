#65:check_replyto   this none this rxd

"... must be object, list of objects, or false...";
value = args[1];
if (typeof(value) == OBJ)
  return {{value}};
elseif (!this:istype(value, {{OBJ}}))
  return $string_utils:capitalize("Object or list of objects expected.");
else
  return {value};
endif
