#24:get_email_address   this none this rxd

set_task_perms(caller_perms());
{who} = args;
if (typeof(who.email_address) == LIST)
  return who.email_address[1];
else
  return who.email_address;
endif
