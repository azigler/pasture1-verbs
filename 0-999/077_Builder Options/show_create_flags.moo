#77:show_create_flags   this none this rxd

if (value = this:get(@args))
  return {value, {tostr("Object flags for @create:  ", value)}};
else
  return {0, {tostr("@create leaves all object flags reset")}};
endif
