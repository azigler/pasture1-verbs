#61:init_for_core   this none this rxd

if (caller_perms().wizard)
  pass(@args);
  this.description = "It's the current issue of the News, dated %d.";
  this.moderated = 1;
  this.last_news_time = 0;
  this.readers = 1;
  this.expire_period = 0;
  this.archive_news = {};
  $mail_agent:send_message(#2, this, "Welcome to LambdaCore", $wiz_utils.new_core_message);
  this:add_news("$");
else
  return E_PERM;
endif
