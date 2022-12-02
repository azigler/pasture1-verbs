#24:set_email_address   this none this rxd

set_task_perms(caller_perms());
{who, email} = args;
if (typeof(who.email_address) == LIST)
  who.email_address[1] = email;
else
  who.email_address = email;
endif
