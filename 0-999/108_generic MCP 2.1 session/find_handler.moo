#108:find_handler   this none this rxd

{message} = args;
if (assoc = $list_utils:passoc(message, this.message_handlers[2], this.message_handlers[1]))
  return assoc[2];
endif
