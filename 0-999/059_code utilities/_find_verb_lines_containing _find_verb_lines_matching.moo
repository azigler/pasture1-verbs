#59:"_find_verb_lines_containing _find_verb_lines_matching"   this none this rxd

":_find_verb_lines_containing(pattern,object[,casematters])";
":_find_verb_lines_matching(regexp,object[,casematters])";
"number of verbs in object with code having a line containing pattern or matching regexp";
"prints verbname and all offending lines to player";
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
if (typeof(verbs) != LIST)
  return player:notify(tostr("verbs(", o, ") => ", tostr(verbs)));
endif
_grep_verb_code_all = verb == "_find_verb_lines_matching" ? "_egrep_verb_code_all" | "_grep_verb_code_all";
for vnum in [1..length(verbs)]
  found = 0;
  for l in (this:(_grep_verb_code_all)(pattern, o, vnum, casematters))
    owner = verb_info(o, vnum)[1];
    player:notify(tostr(o, ":", verbs[vnum], " [", valid(owner) ? owner.name | "Recycled Player", " (", owner, ")]:  ", l));
    found = 1;
    $command_utils:suspend_if_needed(0);
  endfor
  if (found)
    count = count + 1;
  endif
  if ($command_utils:running_out_of_time())
    player:notify(tostr("...", o));
    suspend(0);
  endif
endfor
return count;
