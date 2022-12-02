#58:"@copy @copy-x @copy-move"   any (at/to) any rd

"Usage:  @copy source:verbname to target[:verbname]";
"  the target verbname, if not given, defaults to that of the source.  If the target verb doesn't already exist, a new verb is installed with the same args, names, code, and permission flags as the source.  Otherwise, the existing target's verb code is overwritten and no other changes are made.";
"This the poor man's version of multiple inheritance... the main problem is that someone may update the verb you're copying and you'd never know.";
"  if @copy-x is used, makes an unusable copy (!x, this none this).  If @copy-move is used, deletes the source verb as well.";
set_task_perms(player);
if (!player.programmer)
  player:notify("You need to be a programmer to do this.");
  player:notify("If you want to become a programmer, talk to a wizard.");
  return;
elseif (verb != "@copy-move" && !$quota_utils:verb_addition_permitted(player))
  player:notify("Verb addition not permitted because quota exceeded.");
  return;
elseif (!(from = $code_utils:parse_verbref(dobjstr)) || !iobjstr)
  player:notify(tostr("Usage:  ", verb, " obj:verb to obj:verb"));
  player:notify(tostr("        ", verb, " obj:verb to obj"));
  player:notify(tostr("        ", verb, " obj:verb to :verb"));
  return;
elseif ($command_utils:object_match_failed(fobj = player:my_match_object(from[1]), from[1]))
  return;
elseif (iobjstr[1] == ":")
  to = {fobj, iobjstr[2..$]};
elseif (!index(iobjstr, ":") || !(to = $code_utils:parse_verbref(iobjstr)))
  iobj = player:my_match_object(iobjstr);
  if ($command_utils:object_match_failed(iobj, iobjstr))
    return;
  endif
  to = {iobj, from[2]};
elseif ($command_utils:object_match_failed(tobj = player:my_match_object(to[1]), to[1]))
  return;
else
  to[1] = tobj;
endif
from[1] = fobj;
if (verb == "@copy-move")
  if (!$perm_utils:controls(player, fobj) && !$quota_utils:verb_addition_permitted(player))
    player:notify("Won't be able to delete old verb.  Quota exceeded, so unable to continue.  Aborted.");
    return;
  elseif ($perm_utils:controls(player, fobj))
    "only try to move if the player controls the verb. Otherwise, skip and treat as regular @copy";
    if (typeof(result = $code_utils:move_verb(@from, @to)) == ERR)
      player:notify(tostr("Unable to move verb from ", from[1], ":", from[2], " to ", to[1], ":", to[2], " --> ", result));
    else
      player:notify(tostr("Moved verb from ", from[1], ":", from[2], " to ", result[1], ":", result[2]));
    endif
    return;
  else
    player:notify("Won't be able to delete old verb.  Treating this as regular @copy.");
  endif
endif
to_firstname = strsub(to[2][1..index(to[2] + " ", " ") - 1], "*", "") || "*";
if (!(hv = $object_utils:has_verb(to[1], to_firstname)) || hv[1] != to[1])
  if (!(info = `verb_info(@from) ! ANY') || !(vargs = `verb_args(@from) ! ANY'))
    player:notify(tostr("Retrieving ", from[1], ":", from[2], " --> ", info && vargs));
    return;
  endif
  if (!player.wizard)
    info[1] = player;
  endif
  if (verb == "@copy-x")
    "... make sure this is an unusable copy...";
    info[2] = strsub(info[2], "x", "");
    vargs = {"this", "none", "this"};
  endif
  if (from[2] != to[2])
    info[3] = to[2];
  endif
  if (ERR == typeof(e = `add_verb(to[1], info, vargs) ! ANY'))
    player:notify(tostr("Adding ", to[1], ":", to[2], " --> ", e));
    return;
  endif
endif
code = `verb_code(@from) ! ANY';
owner = `verb_info(@from)[1] ! ANY';
if (typeof(code) == ERR)
  player:notify(tostr("Couldn't retrieve code from ", from[1].name, " (", from[1], "):", from[2], " => ", code));
  return;
endif
if (owner != player)
  comment = tostr("Copied from ", $string_utils:nn(from[1]), ":", from[2], from[1] == owner ? "" | tostr(" [verb author ", $string_utils:nn(owner), "]"), " at ", ctime());
  code = {$string_utils:print(comment) + ";", @code};
  if (!player:prog_option("copy_expert"))
    player:notify("Use of @copy is discouraged.  Please do not use @copy if you can use inheritance or features instead.  Use @copy carefully, and only when absolutely necessary, as it is wasteful of database space.");
  endif
endif
e = `set_verb_code(to[1], to_firstname, code) ! ANY';
if (ERR == typeof(e))
  player:notify(tostr("Copying ", from[1], ":", from[2], " to ", to[1], ":", to[2], " --> ", e));
elseif (typeof(e) == LIST && e)
  player:notify(tostr("Copying ", from[1], ":", from[2], " to ", to[1], ":", to[2], " -->"));
  player:notify_lines(e);
else
  player:notify(tostr(to[1], ":", to[2], " code set."));
endif
