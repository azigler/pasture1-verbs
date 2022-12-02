#79:do_breakdown   this none this rxd

dobj = args[1];
who = valid(caller_perms()) ? caller_perms() | player;
if (!this:can_peek(who, dobj.owner))
  return E_PERM;
endif
props = $object_utils:all_properties_suspended(dobj);
grand_total = obj_over = this:object_overhead_bytes(dobj);
output = {tostr("Object overhead:  ", obj_over)};
if (props)
  total = 0;
  lines = {};
  output = {@output, "Properties, defined and inherited, sorted by size:"};
  for x in (props)
    $command_utils:suspend_if_needed(0, "...One moment. Working on the breakdown...");
    if (!is_clear_property(dobj, x))
      size = value_bytes(dobj.(x));
      total = total + size;
      if (size)
        lines = {@lines, {x, size}};
      endif
    endif
  endfor
  lines = $list_utils:reverse_suspended($list_utils:sort_suspended(0, lines, $list_utils:slice(lines, 2)));
  for x in (lines)
    $command_utils:suspend_if_needed(0, "...One moment. Working on the breakdown...");
    text = tostr("  ", x[1], ":  ", x[2]);
    output = {@output, text};
  endfor
  output = {@output, tostr("Total size of properties:  ", total)};
  grand_total = grand_total + total;
endif
prop_over = this:property_overhead_bytes(dobj, props);
output = {@output, tostr("Property overhead:  ", prop_over)};
grand_total = grand_total + prop_over;
if (verbs(dobj))
  output = {@output, "Verbs, sorted by size:"};
  total = 0;
  lines = {};
  for x in [1..length(verbs(dobj))]
    $command_utils:suspend_if_needed(0, "...One moment. Working on the breakdown...");
    vname = verb_info(dobj, x)[3];
    size = value_bytes(verb_code(dobj, x, 0, 0)) + length(vname) + 1;
    total = total + size;
    lines = {@lines, {vname, size}};
  endfor
  lines = $list_utils:reverse_suspended($list_utils:sort_suspended(0, lines, $list_utils:slice(lines, 2)));
  for x in (lines)
    $command_utils:suspend_if_needed(0, "...One moment. Working on the breakdown...");
    text = tostr("  ", x[1], ":  ", x[2]);
    output = {@output, text};
  endfor
  output = {@output, tostr("Total size of verbs:  ", total)};
  grand_total = grand_total + total;
  verb_over = this:verb_overhead_bytes(dobj);
  output = {@output, tostr("Verb overhead:  ", verb_over)};
  grand_total = grand_total + verb_over;
endif
output = {@output, tostr("Grand total:  ", grand_total)};
return output;
"Last modified Sun Dec 31 10:12:14 2006 PST, by Roebare (#109000) @ LM.";
