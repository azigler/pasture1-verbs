#11:@*   this none this rxd

"{last_huh}  @<msg_name> <object> is [<text>]";
"If <text> is given calls <object>:set_message(<msg_name>,<text>),";
"otherwise prints the value of the specified message property";
set_task_perms(caller_perms());
nargs = length(args);
pos = "is" in args;
if (pos == 1)
  player:notify(tostr("Usage:  ", verb, " <object> is <message>"));
  return;
endif
dobjstr = $string_utils:from_list(args[1..pos - 1], " ");
message = $string_utils:from_list(args[pos + 1..nargs], " ");
msg_name = verb[2..$];
dobj = player:my_match_object(dobjstr);
if ($command_utils:object_match_failed(dobj, dobjstr))
  "... oh well ...";
elseif (pos == nargs)
  if (E_PROPNF == (get = `dobj.(msg_name + "_msg") ! ANY'))
    player:notify(tostr(dobj.name, " (", dobj, ") has no \"", msg_name, "\" message."));
  elseif (typeof(get) == ERR)
    player:notify(tostr(get));
  elseif (!get)
    player:notify("Message is not set.");
  else
    player:notify(tostr("The \"", msg_name, "\" message of ", dobj.name, " (", dobj, "):"));
    player:notify(tostr(get));
  endif
else
  set = dobj:set_message(msg_name, message);
  if (set)
    if (typeof(set) == STR)
      player:notify(set);
    else
      player:notify(tostr("You set the \"", msg_name, "\" message of ", dobj.name, " (", dobj, ")."));
    endif
  elseif (set == E_PROPNF)
    player:notify(tostr(dobj.name, " (", dobj, ") has no \"", msg_name, "\" message to set."));
  elseif (typeof(set) == ERR)
    player:notify(tostr(set));
  else
    player:notify(tostr("You clear the \"", msg_name, "\" message of ", dobj.name, " (", dobj, ")."));
  endif
endif
