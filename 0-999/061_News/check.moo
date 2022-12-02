#61:check   this none this rxd

set_task_perms(caller_perms());
if ((player:get_current_message(this) || {0, 0})[2] < this.last_news_time)
  if ((n = player:mail_option("news")) in {0, "all"})
    player:tell("There is new news.  Type `news' to read all news or `news new' to read just new news.");
  elseif (n == "contents")
    player:tell("There is new news.  Type `news all' to read all news or `news new' to read just new news.");
  elseif (n == "new")
    player:tell("There is new news.  Type `news' to read new news, or `news all' to read all news.");
  endif
endif
