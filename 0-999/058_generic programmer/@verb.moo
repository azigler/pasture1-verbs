#58:@verb   any any any rd

set_task_perms(player);
if (!player.programmer)
  player:notify("You need to be a programmer to do this.");
  player:notify("If you want to become a programmer, talk to a wizard.");
  return;
elseif (!$quota_utils:verb_addition_permitted(player))
  player:tell("Verb addition not permitted because quota exceeded.");
  return;
endif
if (!(args && (spec = $code_utils:parse_verbref(args[1]))))
  player:notify(tostr("Usage:  ", verb, " <object>:<verb-name(s)> [<dobj> [<prep> [<iobj> [<permissions> [<owner>]]]]]"));
  return;
elseif ($command_utils:object_match_failed(object = player:my_match_object(spec[1]), spec[1]))
  return;
endif
name = spec[2];
"...Adding another verb of the same name is often a mistake...";
namelist = $string_utils:explode(name);
for n in (namelist)
  if (i = index(n, "*"))
    n = n[1..i - 1] + n[i + 1..$];
  endif
  if ((hv = $object_utils:has_verb(object, n)) && hv[1] == object)
    player:notify(tostr("Warning:  Verb `", n, "' already defined on that object."));
  endif
endfor
if (typeof(pas = $code_utils:parse_argspec(@listdelete(args, 1))) != LIST)
  player:notify(tostr(pas));
  return;
endif
verbargs = pas[1] || (player:prog_option("verb_args") || {});
verbargs = {@verbargs, "none", "none", "none"}[1..3];
rest = pas[2];
if (verbargs == {"this", "none", "this"})
  perms = player:prog_option("verb_perms") || "rxd";
  if (!index(perms, "x"))
    perms = perms + "x";
  endif
else
  perms = player:prog_option("verb_perms") || "rd";
endif
if (rest)
  perms = $perm_utils:apply(perms, rest[1]);
endif
if (length(rest) < 2)
  owner = player;
elseif (length(rest) > 2)
  player:notify(tostr("\"", rest[3], "\" unexpected."));
  return;
elseif ($command_utils:player_match_result(owner = $string_utils:match_player(rest[2]), rest[2])[1])
  return;
elseif (owner == $nothing)
  player:notify("Verb can't be owned by no one!");
  return;
endif
try
  x = add_verb(object, {owner, perms, name}, verbargs);
  player:notify(tostr("Verb added (", x > 0 ? x | length($object_utils:accessible_verbs(object)), ")."));
except (E_INVARG)
  player:notify(tostr(rest ? tostr("\"", perms, "\" is not a valid set of permissions.") | tostr("\"", verbargs[2], "\" is not a valid preposition (?)")));
except e (ANY)
  player:notify(e[2]);
endtry
