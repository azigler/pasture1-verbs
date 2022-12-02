#6:@rename*#   any (at/to) any rd

if (player != caller || player != this)
  return;
endif
set_task_perms(player);
bynumber = verb == "@rename#";
spec = $code_utils:parse_verbref(dobjstr);
if (spec)
  if (!player.programmer)
    return player:notify(tostr(E_PERM));
  endif
  object = this:my_match_object(spec[1]);
  if (!$command_utils:object_match_failed(object, spec[1]))
    vname = spec[2];
    if (bynumber)
      vname = $code_utils:toint(vname);
      if (vname == E_TYPE)
        return player:notify("Verb number expected.");
      elseif (vname < 1 || `vname > length(verbs(object)) ! E_PERM => 0')
        return player:notify("Verb number out of range.");
      endif
    endif
    try
      info = verb_info(object, vname);
      try
        result = set_verb_info(object, vname, listset(info, iobjstr, 3));
        player:notify("Verb name changed.");
      except e (ANY)
        player:notify(e[2]);
      endtry
    except (E_VERBNF)
      player:notify("That object does not define that verb.");
    except e (ANY)
      player:notify(e[2]);
    endtry
  endif
elseif (bynumber)
  player:notify("@rename# can only be used with verbs.");
elseif (pspec = $code_utils:parse_propref(dobjstr))
  if (!player.programmer)
    return player:notify(tostr(E_PERM));
  endif
  object = this:my_match_object(pspec[1]);
  if (!$command_utils:object_match_failed(object, pspec[1]))
    pname = pspec[2];
    try
      info = property_info(object, pname);
      try
        result = set_property_info(object, pname, {@info, iobjstr});
        player:notify("Property name changed.");
      except e (ANY)
        player:notify(e[2]);
      endtry
    except (E_PROPNF)
      player:notify("That object does not define that property.");
    except e (ANY)
      player:notify(e[2]);
    endtry
  endif
else
  object = this:my_match_object(dobjstr);
  if (!$command_utils:object_match_failed(object, dobjstr))
    old_name = object.name;
    old_aliases = object.aliases;
    if (e = $building_utils:set_names(object, iobjstr))
      if (strcmp(object.name, old_name) == 0)
        name_message = tostr("Name of ", object, " (", old_name, ") is unchanged");
      else
        name_message = tostr("Name of ", object, " changed to \"", object.name, "\"");
      endif
      aliases = $string_utils:from_value(object.aliases, 1);
      if (object.aliases == old_aliases)
        alias_message = tostr(".  Aliases are unchanged (", aliases, ").");
      else
        alias_message = tostr(", with aliases ", aliases, ".");
      endif
      player:notify(name_message + alias_message);
    elseif (e == E_INVARG)
      player:notify("That particular name change not allowed (see help @rename).");
      if (object == player)
        player:notify($player_db:why_bad_name(player, iobjstr));
      endif
    elseif (e == E_NACC)
      player:notify("Oops.  You can't update that name right now; try again in a few minutes.");
    elseif (e == E_ARGS)
      player:notify(tostr("Sorry, name too long.  Maximum number of characters in a name:  ", $login.max_player_name));
    elseif (e == 0)
      player:notify("Name and aliases remain unchanged.");
    else
      player:notify(tostr(e));
    endif
  endif
endif
