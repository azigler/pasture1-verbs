#58:@rmverb*#   any none none rd

set_task_perms(player);
if (!(args && (spec = $code_utils:parse_verbref(args[1]))))
  player:notify(tostr("Usage:  ", verb, " <object>:<verb>"));
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  "...bogus object...";
elseif (typeof(argspec = $code_utils:parse_argspec(@listdelete(args, 1))) != LIST)
  player:notify(tostr(argspec));
elseif (argspec[2])
  player:notify($string_utils:from_list(argspec[2], " ") + "??");
elseif (length(argspec = argspec[1]) in {1, 2})
  player:notify({"Missing preposition", "Missing iobj specification"}[length(argspec)]);
else
  verbname = spec[2];
  if (verb == "@rmverb#")
    loc = $code_utils:toint(verbname);
    if (loc == E_TYPE)
      return player:notify("Verb number expected.");
    elseif (loc < 1 || loc > `length(verbs(object)) ! E_PERM => 0')
      return player:notify("Verb number out of range.");
    endif
  else
    if (index(verbname, "*") > 1)
      verbname = strsub(verbname, "*", "");
    endif
    loc = $code_utils:find_last_verb_named(object, verbname);
    if (argspec)
      argspec[2] = $code_utils:full_prep(argspec[2]) || argspec[2];
      while (loc != -1 && `verb_args(object, loc) ! ANY' != argspec)
        loc = $code_utils:find_last_verb_named(object, verbname, loc - 1);
      endwhile
    endif
    if (loc < 0)
      player:notify(tostr("That object does not define that verb", argspec ? " with those args." | "."));
      return;
    endif
  endif
  info = `verb_info(object, loc) ! ANY';
  vargs = `verb_args(object, loc) ! ANY';
  vcode = `verb_code(object, loc, 1, 1) ! ANY';
  try
    delete_verb(object, loc);
    if (info)
      player:notify(tostr("Verb ", object, ":", info[3], " (", loc, ") {", $string_utils:from_list(vargs, " "), "} removed."));
      if (player:prog_option("rmverb_mail_backup"))
        $mail_agent:send_message(player, player, tostr(object, ":", info[3], " (", loc, ") {", $string_utils:from_list(vargs, " "), "}"), vcode);
      endif
    else
      player:notify(tostr("Unreadable verb ", object, ":", loc, " removed."));
    endif
  except e (ANY)
    player:notify(e[2]);
  endtry
endif
