#76:show   this none this rxd

if (o = (name = args[2]) in {"list_numbers"})
  args[2] = {"list_no_numbers"}[o];
  return {@pass(@args), tostr("(", name, " is a synonym for -", args[2], ")")};
else
  return pass(@args);
endif
