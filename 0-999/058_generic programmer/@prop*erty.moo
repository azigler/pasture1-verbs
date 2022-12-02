#58:@prop*erty   any any any rd

set_task_perms(player);
if (!player.programmer)
  player:notify("You need to be a programmer to do this.");
  player:notify("If you want to become a programmer, talk to a wizard.");
  return;
elseif (!$quota_utils:property_addition_permitted(player))
  player:tell("Property addition not permitted because quota exceeded.");
  return;
endif
nargs = length(args);
usage = tostr("Usage:  ", verb, " <object>.<prop-name> [<init_value> [<perms> [<owner>]]]");
if (nargs < 1 || !(spec = $code_utils:parse_propref(args[1])))
  player:notify(usage);
  return;
endif
object = player:my_match_object(spec[1]);
name = spec[2];
if ($command_utils:object_match_failed(object, spec[1]))
  return;
endif
if (nargs < 2)
  value = 0;
else
  q = $string_utils:prefix_to_value(argstr[$string_utils:word_start(argstr)[2][1]..$]);
  if (q[1] == 0)
    player:notify(tostr("Syntax error in initial value:  ", q[2]));
    return;
  endif
  value = q[2];
  args = {args[1], value, @$string_utils:words(q[1])};
  nargs = length(args);
endif
default = player:prog_option("@prop_flags");
if (!default)
  default = "rc";
endif
perms = nargs < 3 ? default | $perm_utils:apply(default, args[3]);
if (nargs < 4)
  owner = player;
else
  owner = $string_utils:match_player(args[4]);
  if ($command_utils:player_match_result(owner, args[4])[1])
    return;
  endif
endif
if (nargs > 4)
  player:notify(usage);
  return;
endif
try
  add_property(object, name, value, {owner, perms});
  player:notify(tostr("Property added with value ", toliteral(object.(name)), "."));
except (E_INVARG)
  if ($object_utils:has_property(object, name))
    player:notify(tostr("Property ", object, ".", name, " already exists."));
  else
    for i in [1..length(perms)]
      if (!index("rcw", perms[i]))
        player:notify(tostr("Unknown permission bit:  ", perms[i]));
        return;
      endif
    endfor
    "...the only other possibility...";
    player:notify("Property is already defined on one or more descendents.");
    player:notify(tostr("Try @check-prop ", args[1]));
  endif
except e (ANY)
  player:notify(e[2]);
endtry
