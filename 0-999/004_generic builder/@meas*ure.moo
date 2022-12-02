#4:@meas*ure   any any any rd

"Syntax:";
"  @measure object <object name>";
"  @measure summary [player]";
"  @measure new [player]";
"  @measure breakdown <object name>";
"  @measure recent [number of days] [player]";
if (length(args) < 1)
  player:tell_lines($code_utils:verb_documentation());
  return;
endif
if (index("object", args[1]) == 1)
  "Object.";
  what = player.location:match_object(name = $string_utils:from_list(args[2..$], " "));
  lag = $login:current_lag();
  if (!valid(what))
    player:tell("Sorry, I didn't understand `", name, "'");
  elseif ($object_utils:has_property(what, "object_size") && what.object_size[1] > $byte_quota_utils.too_large && !player.wizard && player != $byte_quota_utils.owner && player != $hacker && player != what.owner && lag > 0)
    player:tell($string_utils:nn(what), " when last measured was ", $string_utils:group_number(what.object_size[1]), " bytes.  To reduce lag induced by multiple players re-measuring large objects multiple times, you may not measure that object.");
  elseif (lag > 0 && `what.object_size[2] ! ANY => 0' > time() - 86400 && !$command_utils:yes_or_no(tostr("That object was measured only ", $string_utils:from_seconds(time() - what.object_size[2]), " ago.  Please don't lag the MOO by remeasuring things frequently.  Are you sure you want to remeasure it?")))
    return player:tell("Not measuring.  It was ", $string_utils:group_number(what.object_size[1]), " bytes when last measured.");
  else
    player:tell("Checking size of ", what.name, " (", what, ")...");
    player:tell("Size of ", what.name, " (", what, ") is ", $string_utils:group_number($byte_quota_utils:object_bytes(what)), " bytes.");
  endif
elseif (index("summary", args[1]) == 1)
  "Summarize player.";
  if (length(args) == 1)
    what = player;
  else
    what = $string_utils:match_player(name = $string_utils:from_list(args[2..$], " "));
  endif
  if (!valid(what))
    player:tell("Sorry, I don't know who you mean by `", name, "'");
  else
    $byte_quota_utils:do_summary(what);
  endif
elseif (index("new", args[1]) == 1)
  if (length(args) == 1)
    what = player;
  elseif (!valid(what = $string_utils:match_player(name = $string_utils:from_list(args[2..$], " "))))
    return $command_utils:player_match_failed(what, name);
  endif
  player:tell("Measuring the sizes of ", what.name, "'s recently created objects...");
  total = 0;
  unmeasured_index = 4;
  unmeasured_multiplier = 100;
  nunmeasured = 0;
  if (typeof(what.owned_objects) == LIST)
    for x in (what.owned_objects)
      if (!$object_utils:has_property(x, "object_size"))
        nunmeasured = nunmeasured + 1;
      elseif (!x.object_size[1])
        player:tell("Measured ", $string_utils:nn(x), ":  ", size = $byte_quota_utils:object_bytes(x), " bytes.");
        total = total + size;
      endif
      $command_utils:suspend_if_needed(5);
    endfor
    if (nunmeasured && what.size_quota[unmeasured_index] < unmeasured_multiplier * nunmeasured)
      what.size_quota[unmeasured_index] = what.size_quota[unmeasured_index] % unmeasured_multiplier + nunmeasured * unmeasured_multiplier;
    endif
    player:tell("Total bytes used in new creations: ", total, ".", nunmeasured ? tostr(" There were a total of ", nunmeasured, " object(s) found with no .object_size property. This will prevent additional building.") | "");
  else
    player:tell("Sorry, ", what.name, " is not enrolled in the object measurement scheme.");
  endif
elseif (index("recent", args[1]) == 1)
  "@measure recent days player";
  if (length(args) > 1)
    days = $code_utils:toint(args[2]);
  else
    days = $byte_quota_utils.cycle_days;
  endif
  if (!days)
    return player:tell("Couldn't understand `", args[2], "' as a positive integer.");
  endif
  if (length(args) > 2)
    if (!valid(who = $string_utils:match_player(name = $string_utils:from_list(args[3..$], " "))))
      return $command_utils:player_match_failed(who, name);
    endif
  else
    who = player;
  endif
  if (typeof(who.owned_objects) == LIST)
    player:tell("Re-measuring objects of ", $string_utils:nn(who), " which have not been measured in the past ", days, " days.");
    when = time() - days * 86400;
    which = {};
    for x in (who.owned_objects)
      if (x.object_size[2] < when)
        $byte_quota_utils:object_size(x);
        which = setadd(which, x);
        $command_utils:suspend_if_needed(3, "...measuring");
      endif
    endfor
    player:tell("Done, re-measured ", length(which), " objects.", length(which) > 0 ? "  Recommend you use @measure summary to update the display of @quota." | "");
  else
    player:tell("Sorry, ", who.name, " is not enrolled in the object measurement scheme.");
  endif
elseif (index("breakdown", args[1]) == 1)
  what = player.location:match_object(name = $string_utils:from_list(args[2..$], " "));
  if (!valid(what))
    player:tell("Sorry, I didn't understand `", name, "'");
  elseif (!$byte_quota_utils:can_peek(player, what.owner))
    return player:tell("Sorry, you don't control ", what.name, " (", what, ")");
  else
    if (mail = $command_utils:yes_or_no("This might be kinda long.  Want me to mail you the result?"))
      player:tell("Result will be mailed.");
    endif
    info = $byte_quota_utils:do_breakdown(what);
    if (typeof(info) == ERR)
      player:tell(info);
    endif
    if (mail)
      $mail_agent:send_message($byte_quota_utils.owner, {player}, tostr("Object breakdown of ", what.name, " (", what, ")"), info);
    else
      player:tell_lines_suspended(info);
    endif
  endif
else
  player:tell("Not a sub-command of @measure: ", args[1]);
  player:tell_lines($code_utils:verb_documentation());
endif
