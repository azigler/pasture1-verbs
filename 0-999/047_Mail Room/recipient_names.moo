#47:recipient_names   this none this rxd

return this:ok(who = args[1]) && $mail_agent:name_list(@this.recipients[who]);
