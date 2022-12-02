#47:parse_invoke   this none this rxd

"invoke(rcptstrings,verb[,subject]) for a @send";
"invoke(1,verb,rcpts,subject,replyto,body) if no parsing is needed";
"invoke(2,verb,msg,flags,replytos) for an @answer";
if (!(which = args[1]))
  player:tell_lines({tostr("Usage:  ", args[2], " <list-of-recipients>"), tostr("        ", args[2], "                      to continue with a previous draft")});
elseif (typeof(which) == LIST)
  "...@send...";
  if (rcpts = this:parse_recipients({}, which))
    if (replyto = player:mail_option("replyto"))
      replyto = this:parse_recipients({}, replyto, ".mail_options: ");
    endif
    if (0 == (subject = {@args, 0}[3]))
      if (player:mail_option("nosubject"))
        subject = "";
      else
        player:tell("Subject:");
        subject = $command_utils:read();
      endif
    endif
    return {rcpts, subject, replyto, {}};
  endif
elseif (which == 1)
  return args[3..6];
elseif (!(to_subj = this:parse_msg_headers(msg = args[3], flags = args[4])))
else
  include = {};
  if ("include" in flags)
    prefix = ">            ";
    for line in ($mail_agent:to_text(@msg))
      if (!line)
        prefix = ">  ";
        include = {@include, prefix};
      else
        include = {@include, @this:fill_string(">  " + line, 70, prefix)};
      endif
    endfor
  endif
  return {@to_subj, args[5], include};
endif
return 0;
