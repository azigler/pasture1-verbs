#57:@chown*#   any any any rd

if (!player.wizard || player != this)
  player:notify("Sorry.");
  return;
endif
set_task_perms(player);
args = setremove(args, "to");
if (length(args) != 2 || !args[2])
  player:notify(tostr("Usage:  ", verb, " <object-or-property-or-verb> <owner>"));
  return;
endif
what = args[1];
owner = $string_utils:match_player(args[2]);
bynumber = verb == "@chown#";
if ($command_utils:player_match_result(owner, args[2])[1])
elseif (spec = $code_utils:parse_verbref(what))
  object = this:my_match_object(spec[1]);
  if (!$command_utils:object_match_failed(object, spec[1]))
    vname = spec[2];
    if (bynumber)
      vname = $code_utils:toint(vname);
      if (vname == E_TYPE)
        return player:notify("Verb number expected.");
      elseif (vname < 1 || vname > length(verbs(object)))
        return player:notify("Verb number out of range.");
      endif
    endif
    info = `verb_info(object, vname) ! ANY';
    if (info == E_VERBNF)
      player:notify("That object does not define that verb.");
    elseif (typeof(info) == ERR)
      player:notify(tostr(info));
    else
      try
        result = set_verb_info(object, vname, listset(info, owner, 1));
        player:notify("Verb owner set.");
      except e (ANY)
        player:notify(e[2]);
      endtry
    endif
  endif
elseif (bynumber)
  player:notify("@chown# can only be used with verbs.");
elseif (index(what, ".") && (spec = $code_utils:parse_propref(what)))
  object = this:my_match_object(spec[1]);
  if (!$command_utils:object_match_failed(object, spec[1]))
    pname = spec[2];
    e = $wiz_utils:set_property_owner(object, pname, owner);
    if (e == E_NONE)
      player:notify("+c Property owner set.  Did you really want to do that?");
    else
      player:notify(tostr(e && "Property owner set."));
    endif
  endif
else
  object = this:my_match_object(what);
  if (!$command_utils:object_match_failed(object, what))
    player:notify(tostr($wiz_utils:set_owner(object, owner) && "Object ownership changed."));
  endif
endif
