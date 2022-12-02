#58:@args*#   any any any rd

if (player != caller)
  return;
endif
set_task_perms(player);
if (!player.programmer)
  player:notify("You need to be a programmer to do this.");
  player:notify("If you want to become a programmer, talk to a wizard.");
  return;
endif
if (!(args && (spec = $code_utils:parse_verbref(args[1]))))
  player:notify(tostr(args ? "\"" + args[1] + "\"?  " | "", "<object>:<verb>  expected."));
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  "...can't find object...";
else
  if (verb == "@args#")
    name = $code_utils:toint(spec[2]);
    if (name == E_TYPE)
      return player:notify("Verb number expected.");
    elseif (name < 1 || `name > length(verbs(object)) ! E_PERM => 0')
      return player:notify("Verb number out of range.");
    endif
  else
    name = spec[2];
  endif
  try
    info = verb_args(object, name);
    if (typeof(pas = $code_utils:parse_argspec(@listdelete(args, 1))) != LIST)
      "...arg spec is bogus...";
      player:notify(tostr(pas));
    elseif (!(newargs = pas[1]))
      player:notify($string_utils:from_list(info, " "));
    elseif (pas[2])
      player:notify(tostr("\"", pas[2][1], "\" unexpected."));
    else
      info[2] = info[2][1..index(info[2] + "/", "/") - 1];
      info = {@newargs, @info[length(newargs) + 1..$]};
      try
        result = set_verb_args(object, name, info);
        player:notify("Verb arguments changed.");
      except (E_INVARG)
        player:notify(tostr("\"", info[2], "\" is not a valid preposition (?)"));
      except error (ANY)
        player:notify(error[2]);
      endtry
    endif
  except (E_VERBNF)
    player:notify("That object does not have a verb with that name.");
  except error (ANY)
    player:notify(error[2]);
  endtry
endif
