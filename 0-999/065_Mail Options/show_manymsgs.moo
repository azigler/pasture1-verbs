#65:show_manymsgs   this none this rxd

value = this:get(@args);
if (value)
  return {tostr(value), {tostr("Query when asking for ", value, " or more messages.")}};
else
  return {0, {"Willing to be spammed with arbitrarily many messages/headers"}};
endif
