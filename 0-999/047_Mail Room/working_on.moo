#47:working_on   this none this rxd

return this:ok(who = args[1]) && tostr("a letter ", this:sending(who) ? "(in transit) " | "", "to ", this:recipient_names(who), (subject = `this.subjects[who] ! ANY') && tostr(" entitled \"", subject, "\""));
