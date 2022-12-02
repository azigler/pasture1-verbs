#40:parse_folder_spec   this none this rxd

":parse_folder_spec(verb,args,expected_preposition[,allow_trailing_args_p])";
" => {folder, msg_seq_args, trailing_args}";
set_task_perms(caller_perms());
folder = this:current_folder();
if (!prepstr)
  return {folder, args[2], {}};
endif
{verb, args, prep, ?extra = 0} = args;
p = prepstr in args;
if (prepstr != prep)
  "...unexpected preposition...";
  if (extra && !index(prepstr, " "))
    return {folder, args[1..p - 1], args[p..$]};
  else
    player:tell("Usage:  ", verb, " [<message numbers>] [", prep, " <folder/list-name>]");
  endif
elseif (!(p < length(args) && (fname = args[p + 1])))
  "...preposition but no iobj...";
  player:tell(verb, " ", $string_utils:from_list(args, " "), " WHAT?");
elseif ($mail_agent:match_failed(folder = $mail_agent:match_recipient(fname, this), fname))
  "...bogus mail folder...";
else
  return {folder, args[1..p - 1], args[p + 2..$]};
endif
return 0;
