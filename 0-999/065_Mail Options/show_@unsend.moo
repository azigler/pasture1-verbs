#65:show_@unsend   this none this rxd

if (value = this:get(@args))
  return {"", {tostr("Default message sequence for @unsend:  ", typeof(value) == STR ? value | $string_utils:from_list(value, " "))}};
else
  default = $mail_agent.("player_default_@unsend");
  return {0, {tostr("Default message sequence for @unsend:  ", typeof(default) == STR ? default | $string_utils:from_list(default, " "))}};
endif
