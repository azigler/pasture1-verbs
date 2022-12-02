#108:strip_prefix   this none this rxd

{prefix, message} = args;
if (index(message, prefix + "-") == 1)
  return message[length(prefix) + 2..$];
elseif (index(message, prefix) == 1)
  return message[length(prefix) + 1..$];
elseif (message == prefix)
  return "";
else
  return message;
endif
