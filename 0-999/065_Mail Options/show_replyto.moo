#65:show_replyto   this none this rxd

if (value = this:get(@args))
  return {"", {tostr("Default Reply-to:  ", $mail_agent:name_list(@value))}};
else
  return {0, {"No default Reply-to: field"}};
endif
