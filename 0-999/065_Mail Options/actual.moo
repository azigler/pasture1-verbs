#65:actual   this none this rxd

if (i = args[1] in {"noinclude", "sender"})
  return {{{"include", "all"}[i], !args[2]}};
else
  return {args};
endif
