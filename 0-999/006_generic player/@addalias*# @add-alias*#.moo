#6:"@addalias*# @add-alias*#"   any (at/to) any rd

"Syntax: @addalias <alias>[,...,<alias>] to <object>";
"        @addalias <alias>[,...,<alias>] to <object>:<verb>";
"";
"The first form is used to add aliases to an object's list of aliases.  You can separate multiple aliases with commas.  The aliases will be checked against the object's current aliases and all aliases not already in the object's list of aliases will be added.";
"";
"Example:";
"Muchkin wants to add new aliases to Rover the Wonder Dog:";
"  @addalias Dog,Wonder Dog to Rover";
"Since Rover the Wonder Dog already has the alias \"Dog\" but does not have the alias \"Wonder Dog\", Munchkin sees:";
"  Rover the Wonder Dog(#4237) already has the alias Dog.";
"  Alias Wonder Dog added to Rover the Wonder Dog(#4237).";
"";
"If the object is a player, spaces will also be assumed to be separations between aliases and each alias will be checked against the Player Name Database to make sure no one else is using it. Any already used aliases will be identified.";
"";
"Example:";
"Munchkin wants to add his nicknames to his own list of aliases:";
"  @addalias Foobar Davey to me";
"@Addalias recognizes that Munchkin is trying to add an alias to a valid player and checks the aliases against the Player Name Database.  Unfortunately, DaveTheMan is already using the alias \"Davey\" so Munchkin sees:";
"  DaveTheMan(#5432) is already using the alias Davey";
"  Alias Foobar added to Munchkin(#1523).";
"";
"The second form of the @addalias command is for use by programmers, to add aliases to a verb they own.  All commas and spaces are assumed to be separations between aliases.";
if (player != this)
  return;
endif
set_task_perms(player);
bynumber = verb[$] == "#";
spec = $code_utils:parse_verbref(iobjstr);
if (spec)
  if (!player.programmer)
    return player:notify(tostr(E_PERM));
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
      used = {};
      for alias in (new_aliases = $list_utils:remove_duplicates($string_utils:explode(strsub(dobjstr, ",", " "))))
        if (alias in old_aliases)
          used = {@used, alias};
          new_aliases = setremove(new_aliases, alias);
        endif
      endfor
      if (used)
        player:notify(tostr(object.name, "(", object, "):", vname, " already has the alias", length(used) > 1 ? "es" | "", " ", $string_utils:english_list(used), "."));
      endif
      if (new_aliases)
        info = listset(info, aliases = $string_utils:from_list({@old_aliases, @new_aliases}, " "), 3);
        try
          result = set_verb_info(object, vname, info);
          player:notify(tostr("Alias", length(new_aliases) > 1 ? "es" | "", " ", $string_utils:english_list(new_aliases), " added to verb ", object.name, "(", object, "):", vname));
          player:notify(tostr("Verbname is now ", object.name, "(", object, "):\"", aliases, "\""));
        except e (ANY)
          player:notify(e[2]);
        endtry
      endif
      if (!new_aliases && !used)
        "Pathological case, we failed to parse dobjstr, possibly consisted only of commas, spaces, or just the empty string";
        player:notify("Did not understand what aliases to add from value:  " + dobjstr);
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
    used = {};
    for alias in (new_aliases = $list_utils:remove_duplicates($list_utils:map_arg($string_utils, "trim", $string_utils:explode(is_player(object) ? strsub(dobjstr, " ", ",") | dobjstr, ","))))
      if (alias in old_aliases)
        used = {@used, alias};
        new_aliases = setremove(new_aliases, alias);
      elseif (is_player(object) && valid(someone = $player_db:find_exact(alias)))
        player:notify(tostr(someone.name, "(", someone, ") is already using the alias ", alias, "."));
        new_aliases = setremove(new_aliases, alias);
      endif
    endfor
    if (used)
      player:notify(tostr(object.name, "(", object, ") already has the alias", length(used) > 1 ? "es" | "", " ", $string_utils:english_list(used), "."));
    endif
    if (new_aliases)
      if ((e = object:set_aliases(aliases = {@old_aliases, @new_aliases})) && object.aliases == aliases)
        player:notify(tostr("Alias", length(new_aliases) > 1 ? "es" | "", " ", $string_utils:english_list(new_aliases), " added to ", object.name, "(", object, ")."));
        player:notify(tostr("Aliases for ", $string_utils:nn(object), " are now ", $string_utils:from_value(aliases, 1)));
      elseif (e)
        player:notify("That particular name change not allowed (see help @rename or help @addalias).");
      elseif (e == E_INVARG)
        if ($object_utils:has_property(#0, "local"))
          if ($object_utils:has_property($local, "max_player_aliases"))
            max = $local.max_player_aliases;
            player:notify("You are not allowed more than " + tostr(max) + " aliases.");
          endif
        else
          player:notify("You are not allowed any more aliases.");
        endif
      elseif (e == E_NACC)
        player:notify("Oops.  You can't update that object's aliases right now; try again in a few minutes.");
      elseif (e == 0)
        player:notify("Aliases not changed as expected!");
        player:notify(tostr("Aliases for ", $string_utils:nn(object), " are now ", $string_utils:from_value(object.aliases, 1)));
      else
        player:notify(tostr(e));
      endif
    else
      player:tell("No new aliases found to add.");
    endif
  endif
endif
