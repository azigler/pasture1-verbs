#59:"_find_verbs_containing _find_verbs_matching"   this none this rxd

":_find_verbs_containing(pattern,object[,casematters])";
":_find_verbs_matching(regexp,object[,casematters])";
"number of verbs in object with code having a line containing pattern or matching regexp";
"prints verbname and offending line to player";
set_task_perms(caller_perms());
{pattern, o, ?casematters = 0} = args;
if ($command_utils:running_out_of_time())
  player:notify(tostr("...", o));
  suspend(0);
endif
if (!valid(o))
  return 0;
endif
count = 0;
verbs = $object_utils:accessible_verbs(o);
_grep_verb_code = verb == "_find_verbs_matching" ? "_egrep_verb_code" | "_grep_verb_code";
if (typeof(verbs) != LIST)
  return player:notify(tostr("verbs(", o, ") => ", tostr(verbs)));
endif
for vnum in [1..length(verbs)]
  if (l = this:(_grep_verb_code)(pattern, o, vnum, casematters))
    owner = verb_info(o, vnum)[1];
    player:notify(tostr(o, ":", verbs[vnum], " [", valid(owner) ? owner.name | "Recycled Player", " (", owner, ")]:  ", l));
    count = count + 1;
  endif
  if ($command_utils:running_out_of_time())
    player:notify(tostr("...", o));
    suspend(0);
  endif
endfor
return count;
