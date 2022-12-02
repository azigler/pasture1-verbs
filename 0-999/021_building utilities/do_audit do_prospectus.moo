#21:"do_audit do_prospectus"   this none this rxd

":do_audit(who, start, end, match)";
"audit who, with objects from start to end that match 'match'";
":do_prospectus(...)";
"same, but with verb counts";
{who, start, end, match} = args;
pros = verb == "do_prospectus";
"the set_task_perms is to make the task owned by the player. There are no other security aspects";
set_task_perms(caller_perms());
if (start == 0 && end == toint(max_object()) && !match && typeof(who.owned_objects) == LIST && length(who.owned_objects) > 100 && !$command_utils:yes_or_no(tostr(who.name, " has ", length(who.owned_objects), " objects.  This will be a very long list.  Do you wish to proceed?")))
  v = pros ? "@prospectus" | "@audit";
  return player:tell(v, " aborted.  Usage:  ", v, " [player] [from <start>] [to <end>] [for <match>]");
endif
player:tell(tostr("Objects owned by ", who.name, " (from #", start, " to #", end, match ? " matching " + match | "", ")", ":"));
count = bytes = 0;
if (typeof(who.owned_objects) == LIST)
  for o in (who.owned_objects)
    $command_utils:suspend_if_needed(0);
    if (!player:is_listening())
      return;
    endif
    if (typeof(o) == ANON || (toint(o) >= start && toint(o) <= end))
      didit = this:do_audit_item(o, match, pros);
      count = count + didit;
      if (didit && $quota_utils.byte_based && $object_utils:has_property(o, "object_size"))
        bytes = bytes + o.object_size[1];
      endif
    endif
  endfor
else
  for i in [start..end]
    $command_utils:suspend_if_needed(0);
    o = toobj(i);
    if ($recycler:valid(o) && o.owner == who)
      didit = this:do_audit_item(o, match, pros);
      count = count + didit;
      if (didit && $quota_utils.byte_based && $object_utils:has_property(o, "object_size"))
        bytes = bytes + o.object_size[1];
      endif
    endif
  endfor
endif
player:tell($string_utils:left(tostr("-- ", count, " object", count == 1 ? "." | "s.", $quota_utils.byte_based ? tostr("  Total bytes: ", $string_utils:group_number(bytes), ".") | ""), player:linelen() - 1, "-"));
