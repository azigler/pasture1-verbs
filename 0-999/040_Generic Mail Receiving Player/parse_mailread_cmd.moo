#40:parse_mailread_cmd   this none this rxd

":parse_mailread_cmd(verb,args,default,prep[,trailer])";
"  handles anything of the form  `VERB message_seq [PREP folder ...]'";
"    default is the default msg-seq to use if none given";
"    prep is the expected prepstr (assumes prepstr is set), usually `on'";
"    trailer, if present and true, indicates trailing args are permitted.";
"  returns {recipient object, message_seq, current_msg,\"...\"} or 0";
set_task_perms(caller_perms());
if (!(pfs = this:parse_folder_spec(@listdelete(args, 3))))
  return 0;
endif
{verb, args, default, prep, ?extra = 0} = args;
folder = pfs[1];
cur = this:get_current_message(folder) || {0};
if (typeof(pms = folder:parse_message_seq(pfs[2], @cur)) == LIST)
  rest = {@listdelete(pms, 1), @pfs[3]};
  if (!extra && rest)
    "...everything should have been gobbled by :parse_message_seq...";
    player:tell("I don't understand `", rest[1], "'");
    return 0;
  elseif (pms[1])
    "...we have a nonempty message sequence...";
    return {folder, pms[1], cur, rest};
  elseif (used = length(pfs[2]) + 1 - length(pms))
    "...:parse_message_seq used some words, but didn't get anything out of it";
    pms = "%f %<has> no `" + $string_utils:from_list(pfs[2][1..used], " ") + "' messages.";
  elseif (typeof(pms = folder:parse_message_seq(default, @cur)) == LIST)
    "...:parse_message_seq used nothing, try the default; wow it worked";
    return {folder, pms[1], cur, rest};
  endif
elseif (typeof(pms) == ERR)
  player:tell($mail_agent:name(folder), " is not readable by you.");
  if (!$object_utils:isa(folder, $mail_recipient))
    player:tell("Use * to indicate a non-player mail recipient.");
  endif
  return 0;
endif
if (folder == this)
  subst = {{"%f's", "Your"}, {"%f", "You"}, {"%<has>", "have"}};
elseif (is_player(folder))
  subst = {{"%f", folder.name}, {"%<has>", $gender_utils:get_conj("has", folder)}};
else
  subst = {{"%f", $mail_agent:name(folder)}, {"%<has>", "has"}};
endif
player:tell($string_utils:substitute(pms, {@subst, {"%%", "%"}}));
return 0;
