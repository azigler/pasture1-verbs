#66:actual   this none this rxd

if (i = args[1] in {"parens", "noisy_insert"})
  return {{{"no_parens", "quiet_insert"}[i], !args[2]}};
else
  return {args};
endif
