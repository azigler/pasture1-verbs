#47:message_with_headers   this none this rxd

return this:readable(who = args[1]) || this:ok(who) && $mail_agent:make_message(this.active[who], this.recipients[who], {this.subjects[who], this.replytos[who]}, this:text(who));
