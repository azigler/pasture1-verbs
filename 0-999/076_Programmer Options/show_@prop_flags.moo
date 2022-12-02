#76:show_@prop_flags   this none this rxd

value = this:get(@args);
if (value)
  return {value, {tostr("Default permissions for @property=`", value, "'.")}};
else
  return {0, {"Default permissions for @property=`rc'."}};
endif
