#65:show_news   this none this rxd

if ((value = this:get(@args)) == "all")
  return {value, {"the `news' command will show all news"}};
elseif (value == "contents")
  return {value, {"the `news' command will show the titles of all articles"}};
elseif (value == "new")
  return {value, {"the `news' command will show only new news"}};
else
  return {0, {"the `news' command will show all news"}};
endif
