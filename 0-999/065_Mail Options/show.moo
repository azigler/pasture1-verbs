#65:show   this none this rxd

if (o = (name = args[2]) in {"sender", "noinclude"})
  args[2] = {"all", "include"}[o];
  return {@pass(@args), tostr("(", name, " is a synonym for -", args[2], ")")};
else
  return pass(@args);
endif
