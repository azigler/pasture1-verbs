#104:message_name_to_verbname   this none this rxd

{message} = args;
if ($object_utils:has_callable_verb(this, vname = "handle_" + message))
  return vname;
else
  return 0;
endif
