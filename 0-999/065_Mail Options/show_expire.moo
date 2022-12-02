#65:show_expire   this none this rxd

value = this:get(args[1], "expire");
if (value < 0)
  return {1, {"Messages will not expire."}};
else
  return {value, {tostr("Unkept messages expire in ", $time_utils:english_time(value || $mail_agent.player_expire_time), value ? "" | " (default)")}};
endif
