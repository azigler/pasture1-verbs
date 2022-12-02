#77:"show_dig_room show_dig_exit"   this none this rxd

name = args[2];
what = verb == "show_dig_room" ? "room" | "exit";
if ((value = this:get(args[1], name)) == 0)
  return {0, {tostr("@dig ", what, "s are children of $", what, ".")}};
else
  return {value, {tostr("@dig ", what, "s are children of ", value, " (", valid(value) ? value.name | "invalid", ").")}};
endif
