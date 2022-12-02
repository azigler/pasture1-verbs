#6:"@rmalias*# @rm-alias*#"   any (out of/from inside/from) any rd

"Syntax: @rmalias <alias>[,...,<alias>] from <object>";
"        @rmalias <alias>[,...,<alias>] from <object>:<verb>";
"";
"The first form is used to remove aliases from an object.  If the object is a valid player, space and commas will be assumed to be separations between unwanted aliases.  Otherwise, only commas will be assumed to be separations.";
"[5/10/93 Nosredna: flushed above is_player feature";
"Note that @rmalias will not affect the object's name, only its aliases.";
"";
"The second form is for use by programmers, to remove aliases from a verb they own.  All spaces and commas are assumed to be separations between unwanted aliases.";
if (player != this)
  return;
endif
set_task_perms(player);
bynumber = verb[$] == "#";
spec = $code_utils:parse_verbref(iobjstr);
if (spec)
  if (!player.programmer)
    player:notify(tostr(E_PERM));
  endif
  object = player:my_match_object(spec[1]);
  if (!$command_utils:object_match_failed(object, spec[1]))
    vname = spec[2];
    if (bynumber)
      if ((vname = $code_utils:toint(vname)) == E_TYPE)
        return player:notify("Verb number expected.");
      elseif (vname < 1 || `vname > length(verbs(object)) ! E_PERM => 0')
        return player:notify("Verb number out of range.");
      endif
    endif
    try
      info = verb_info(object, vname);
      old_aliases = $string_utils:explode(info[3]);
      not_used = {};
      for alias in (bad_aliases = $list_utils:remove_duplicates($string_utils:explode(strsub(dobjstr, ",", " "))))
        if (!(alias in old_aliases))
          not_used = {@not_used, alias};
          bad_aliases = setremove(bad_aliases, alias);
        else
          old_aliases = setremove(old_aliases, alias);
        endif
      endfor
      if (not_used)
        player:notify(tostr(object.name, "(", object, "):", vname, " does not have the alias", length(not_used) > 1 ? "es" | "", " ", $string_utils:english_list(not_used), "."));
      endif
      if (bad_aliases && old_aliases)
        info = listset(info, aliases = $string_utils:from_list(old_aliases, " "), 3);
        try
          result = set_verb_info(object, vname, info);
          player:notify(tostr("Alias", length(bad_aliases) > 1 ? "es" | "", " ", $string_utils:english_list(bad_aliases), " removed from verb ", object.name, "(", object, "):", vname));
          player:notify(tostr("Verbname is now ", object.name, "(", object, "):\"", aliases, "\""));
        except e (ANY)
          player:notify(e[2]);
        endtry
      elseif (!old_aliases)
        player:notify("You have to leave a verb with at least one alias.");
      else
        player:notify("No aliases removed.");
      endif
    except (E_VERBNF)
      player:notify("That object does not define that verb.");
    except e (ANY)
      player:notify(e[2]);
    endtry
  endif
elseif (bynumber)
  player:notify(tostr(verb, " can only be used with verbs."));
else
  object = player:my_match_object(iobjstr);
  if (!$command_utils:object_match_failed(object, iobjstr))
    old_aliases = object.aliases;
    not_used = {};
    for alias in (bad_aliases = $list_utils:remove_duplicates($list_utils:map_arg($string_utils, "trim", $string_utils:explode(dobjstr, ","))))
      "removed is_player(object) ? strsub(dobjstr, \" \", \",\") | --Nosredna";
      if (!(alias in old_aliases))
        not_used = {@not_used, alias};
        bad_aliases = setremove(bad_aliases, alias);
      else
        old_aliases = setremove(old_aliases, alias);
      endif
    endfor
    if (not_used)
      player:notify(tostr(object.name, "(", object, ") does not have the alias", length(not_used) > 1 ? "es" | "", " ", $string_utils:english_list(not_used), "."));
    endif
    if (bad_aliases)
      if (e = object:set_aliases(old_aliases))
        player:notify(tostr("Alias", length(bad_aliases) > 1 ? "es" | "", " ", $string_utils:english_list(bad_aliases), " removed from ", object.name, "(", object, ")."));
        player:notify(tostr("Aliases for ", object.name, "(", object, ") are now ", $string_utils:from_value(old_aliases, 1)));
      elseif (e == E_INVARG)
        player:notify("That particular name change not allowed (see help @rename or help @rmalias).");
      elseif (e == E_NACC)
        player:notify("Oops.  You can't update that object's aliases right now; try again in a few minutes.");
      elseif (e == 0)
        player:notify("Aliases not changed as expected!");
        player:notify(tostr("Aliases for ", $string_utils:nn(object), " are ", $string_utils:from_value(object.aliases, 1)));
      else
        player:notify(tostr(e));
      endif
    else
      player:notify("Aliases unchanged.");
    endif
  endif
endif
