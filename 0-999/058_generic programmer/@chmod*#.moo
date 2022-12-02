#58:@chmod*#   any any any rd

set_task_perms(player);
bynumber = verb == "@chmod#";
if (length(args) != 2)
  player:notify(tostr("Usage:  ", verb, " <object-or-property-or-verb> <permissions>"));
  return;
endif
{what, perms} = args;
if (spec = $code_utils:parse_verbref(what))
  if (!player.programmer)
    player:notify("You need to be a programmer to do this.");
    player:notify("If you want to become a programmer, talk to a wizard.");
    return;
  endif
  if (valid(object = player:my_match_object(spec[1])))
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
      if (!valid(owner = info[1]))
        player:notify(tostr("That verb is owned by an invalid object (", owner, "); it needs to be @chowned."));
      elseif (!is_player(owner))
        player:notify(tostr("That verb is owned by a non-player object (", owner.name, ", ", owner, "); it needs to be @chowned."));
      else
        info[2] = perms = $perm_utils:apply(info[2], perms);
        try
          result = set_verb_info(object, vname, info);
          player:notify(tostr("Verb permissions set to \"", perms, "\"."));
        except (E_INVARG)
          player:notify(tostr("\"", perms, "\" is not a valid permissions string for a verb."));
        except e (ANY)
          player:notify(e[2]);
        endtry
      endif
    except (E_VERBNF)
      player:notify("That object does not define that verb.");
    except error (ANY)
      player:notify(error[2]);
    endtry
    return;
  endif
elseif (bynumber)
  return player:notify("@chmod# can only be used for verbs.");
elseif (index(what, ".") && (spec = $code_utils:parse_propref(what)))
  if (valid(object = player:my_match_object(spec[1])))
    pname = spec[2];
    try
      info = property_info(object, pname);
      info[2] = perms = $perm_utils:apply(info[2], perms);
      try
        result = set_property_info(object, pname, info);
        player:notify(tostr("Property permissions set to \"", perms, "\"."));
      except (E_INVARG)
        player:notify(tostr("\"", perms, "\" is not a valid permissions string for a property."));
      except error (ANY)
        player:notify(error[2]);
      endtry
    except (E_PROPNF)
      player:notify("That object does not have that property.");
    except error (ANY)
      player:notify(error[2]);
    endtry
    return;
  endif
elseif (valid(object = player:my_match_object(what)))
  perms = $perm_utils:apply((object.r ? "r" | "") + (object.w ? "w" | "") + (object.f ? "f" | ""), perms);
  r = w = f = 0;
  for i in [1..length(perms)]
    if (perms[i] == "r")
      r = 1;
    elseif (perms[i] == "w")
      w = 1;
    elseif (perms[i] == "f")
      f = 1;
    else
      player:notify(tostr("\"", perms, "\" is not a valid permissions string for an object."));
      return;
    endif
  endfor
  try
    object.r = r;
    object.w = w;
    object.f = f;
    player:notify(tostr("Object permissions set to \"", perms, "\"."));
  except (E_PERM)
    player:notify("Permission denied.");
  endtry
  return;
endif
$command_utils:object_match_failed(object, what);
