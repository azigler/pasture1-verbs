#77:check_create_flags   this none this rxd

value = args[1];
if (m = match(value, "[^rwf]"))
  return tostr("Unknown object flag:  ", value[m[1]]);
else
  return {tostr(index(value, "r") ? "r" | "", index(value, "w") ? "w" | "", index(value, "f") ? "f" | "")};
endif
