#47:"reply-to*: replyto*:"   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
else
  if (args)
    this.replytos[who] = rt = this:parse_recipients({}, args);
    this:set_changed(who, 1);
  else
    rt = this.replytos[who];
  endif
  player:tell(rt ? "Replies will go to " + $mail_agent:name_list(@this.replytos[who]) + "." | "Reply-to field is empty.");
endif
