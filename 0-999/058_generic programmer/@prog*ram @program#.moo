#58:"@prog*ram @program#"   any any any rd

"This version of @program deals with multiple verbs having the same name.";
"... @program <object>:<verbname> <dobj> <prep> <iobj>  picks the right one.";
if (player != caller)
  return;
endif
set_task_perms(player);
"...";
"...catch usage errors first...";
"...";
punt = "...set punt to 0 only if everything works out...";
if (!(args && (spec = $code_utils:parse_verbref(args[1]))))
  player:notify(tostr("Usage: ", verb, " <object>:<verb> [<dobj> <prep> <iobj>]"));
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  "...bogus object...";
elseif (typeof(argspec = $code_utils:parse_argspec(@listdelete(args, 1))) != LIST)
  player:notify(tostr(argspec));
elseif (verb == "@program#")
  verbname = $code_utils:toint(spec[2]);
  if (verbname == E_TYPE)
    player:notify("Verb number expected.");
  elseif (length(args) > 1)
    player:notify("Don't give args for @program#.");
  elseif (verbname < 1 || `verbname > length(verbs(object)) ! E_PERM')
    player:notify("Verb number out of range.");
  else
    argspec = 0;
    punt = 0;
  endif
elseif (argspec[2])
  player:notify($string_utils:from_list(argspec[2], " ") + "??");
elseif (length(argspec = argspec[1]) in {1, 2})
  player:notify({"Missing preposition", "Missing iobj specification"}[length(argspec)]);
else
  punt = 0;
  verbname = spec[2];
  if (index(verbname, "*") > 1)
    verbname = strsub(verbname, "*", "");
  endif
endif
"...";
"...if we have an argspec, we'll need to reset verbname...";
"...";
if (punt)
elseif (argspec)
  if (!(argspec[2] in {"none", "any"}))
    argspec[2] = $code_utils:full_prep(argspec[2]);
  endif
  loc = $code_utils:find_verb_named(object, verbname);
  while (loc > 0 && `verb_args(object, loc) ! ANY' != argspec)
    loc = $code_utils:find_verb_named(object, verbname, loc + 1);
  endwhile
  if (!loc)
    punt = "...can't find it....";
    player:notify("That object has no verb matching that name + args.");
  else
    verbname = loc;
  endif
else
  loc = 0;
endif
"...";
"...get verb info...";
"...";
if (punt || !(punt = "...reset punt to TRUE..."))
else
  try
    info = verb_info(object, verbname);
    punt = 0;
    aliases = info[3];
    if (!loc)
      loc = aliases in (verbs(object) || {});
    endif
  except (E_VERBNF)
    player:notify("That object does not have that verb definition.");
  except error (ANY)
    player:notify(error[2]);
  endtry
endif
"...";
"...read the code...";
"...";
if (punt)
  player:notify(tostr("Now ignoring code for ", args ? args[1] | "nothing in particular", "."));
  $command_utils:read_lines();
  player:notify("Verb code ignored.");
else
  player:notify(tostr("Now programming ", object.name, ":", aliases, "(", !loc ? "??" | loc, ")."));
  lines = $command_utils:read_lines_escape((active = player in $verb_editor.active) ? {} | {"@edit"}, {tostr("You are editing ", $string_utils:nn(object), ":", verbname, "."), @active ? {} | {"Type `@edit' to take this into the verb editor."}});
  if (lines[1] == "@edit")
    $verb_editor:invoke(args[1], "@program", lines[2]);
    return;
  endif
  simpleedit = $mcp.registry:match_package("dns-org-mud-moo-simpleedit");
  if (simpleedit != $failed_match && simpleedit.v_filter_in)
    lines[2] = simpleedit.v_filter_in[1]:(simpleedit.v_filter_in[2])(lines[2]);
  endif
  try
    if (result = set_verb_code(object, verbname, lines[2]))
      player:notify_lines(result);
      player:notify(tostr(length(result), " error(s)."));
      player:notify("Verb not programmed.");
    else
      player:notify("0 errors.");
      player:notify("Verb programmed.");
      if ($code_utils:update_last_modified(object, verbname))
        player:notify("** Time-stamping failed.");
      endif
    endif
  except error (ANY)
    player:notify(error[2]);
    player:notify("Verb not programmed.");
  endtry
endif
