#47:init_session   this none this rxd

{who, recip, subj, replyto, msg} = args;
if (this:ok(who))
  this.sending[who] = 0;
  this.recipients[who] = recip;
  this.subjects[who] = subj;
  this.replytos[who] = replyto || {};
  this:load(who, msg);
  this.active[who]:tell("Composing ", this:working_on(who));
  p = this.active[who];
  "if (p:mail_option(\"enter\") && !args[5])";
  "Changed from above so that @reply can take advantage of @mailoption +enter. Ho_Yan 11/9/94";
  if (p:mail_option("enter"))
    if (typeof(lines = $command_utils:read_lines()) == ERR)
      p:tell(lines);
    else
      this:insert_line(p in this.active, lines, 0);
    endif
  endif
endif
