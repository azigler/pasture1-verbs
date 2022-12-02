#65:check_news   this none this rxd

if ((what = args[1]) in {"new", "contents", "all"})
  return {what};
else
  return "Error: `news' option must be one of `new' or `contents' or `all'";
endif
