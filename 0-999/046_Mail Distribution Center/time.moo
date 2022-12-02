#46:time   this none this rxd

"This was inspired by Xeric's port 4632 on *Core-DB-Issues";
now = time();
return now;
"skipping the below for now because the mail system's clock is getting very out of sync. suspect someone's playing games to run up the clock. HTC 6 Jan 2003";
if (caller == this)
  if (now > this.last_mail_time)
    return this.last_mail_time = now;
  else
    this.time_collisions[2] = this.time_collisions[2] + 1;
    return this.last_mail_time = this.last_mail_time + 1;
  endif
else
  return now;
endif
