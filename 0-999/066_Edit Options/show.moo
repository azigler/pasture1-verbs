#66:show   this none this rxd

if (o = (name = args[2]) in {"parens", "noisy_insert"})
  args[2] = {"no_parens", "quiet_insert"}[o];
  return {@pass(@args), tostr("(", name, " is a synonym for -", args[2], ")")};
else
  return pass(@args);
endif
