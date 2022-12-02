#40:mail_notify   this none this rxd

if (length(this.mail_notify) > 0 && typeof(this.mail_notify[1]) == LIST)
  return this.mail_notify[1];
else
  return this.mail_notify;
endif
