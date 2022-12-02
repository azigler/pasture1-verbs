#72:send_queued_mail   this none this rxd

"$network:send_queued_mail()";
"  -- tries to send the mail stored in the .queued_mail property";
while (queued_mail = this.queued_mail)
  message = queued_mail[1];
  if (!this:raw_sendmail(@message[2]))
    this.queued_mail = setremove(this.queued_mail, message);
  else
    "wait an hour";
    suspend(3600);
  endif
endwhile
