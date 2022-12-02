#102:show_escape   this none this rxd

if (value = this:get(@args))
  return {value, {tostr("Send \"", value, "\" for the escape character.")}};
else
  return {0, {"Use a character 27 as the escape character."}};
endif
