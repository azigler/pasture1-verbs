#76:show_verb_args   this none this rxd

if (value = this:get(@args))
  return {value, {tostr("Default args for @verb:  ", $string_utils:from_list(value, " "))}};
else
  return {0, {"Default args for @verb:  none none none"}};
endif
