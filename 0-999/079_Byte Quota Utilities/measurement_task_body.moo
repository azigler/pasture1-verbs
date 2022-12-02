#79:measurement_task_body   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  num_processed = 0;
  num_repetitions = 0;
  usage_index = 2;
  time_index = 3;
  unmeasured_index = 4;
  players = setremove(players(), $hacker);
  lengthp = length(players);
  index = this.working in players;
  keep_going = 1;
  if (!index)
    "Uh, oh, our guy got reaped while we weren't looking.  Better look for someone else.";
    index = 1;
    while (this.working > players[index] && index < lengthp)
      $command_utils:suspend_if_needed(0);
      index = index + 1;
    endwhile
    this.working = players[index];
  endif
  day = 60 * 60 * 24;
  stop = time() + args[1];
  early = time() - day * this.cycle_days;
  tooidle = day * this.cycle_days;
  "tooidletime is only used if !this.repeat_cycle.";
  tooidletime = time() - tooidle;
  local_per_player_hack = $object_utils:has_verb($local, "per_player_daily_scan");
  while (time() < stop && keep_going)
    who = players[index];
    if (is_player(who) && $object_utils:has_property(who, "size_quota"))
      "Robustness in the face of reaping...";
      if (!this.repeat_cycle || (who.last_disconnect_time > tooidletime && who.last_disconnect_time != $maxint))
        "only measure people who login regularly if we're a big moo.";
        usage = 0;
        unmeasured = 0;
        earliest = time();
        for o in (who.owned_objects)
          if (valid(o) && o.owner == who && !(o in this.exempted))
            "sanity check: might have recycled while we suspended!";
            if ($object_utils:has_property(o, "object_size"))
              if (o.object_size[2] < early)
                usage = usage + this:object_bytes(o);
              else
                usage = usage + o.object_size[1];
                earliest = min(earliest, o.object_size[2]);
              endif
            else
              unmeasured = unmeasured + 1;
            endif
          endif
          $command_utils:suspend_if_needed(3);
        endfor
        if (!is_clear_property(who, "size_quota"))
          who.size_quota[usage_index] = usage;
          who.size_quota[unmeasured_index] = this.unmeasured_multiplier * unmeasured;
          who.size_quota[time_index] = earliest;
        else
          $mail_agent:send_message(player, player, "Quota Violation", {tostr(who, " has a clear .size_quota property."), $string_utils:names_of({who, @$object_utils:ancestors(who)})});
        endif
      elseif (who.size_quota[unmeasured_index])
        "If they managed to create an object *despite* being too idle (presumably programmatically), measure it.";
        this:summarize_one_user(who, -1);
      endif
    elseif (is_player(who))
      "They don't have a size_quota property.  Whine.";
      $mail_agent:send_message(player, player, "Quota Violation", {tostr(who, " doesn't seem to have a .size_quota property."), $string_utils:names_of({who, @$object_utils:ancestors(who)})});
    endif
    if (local_per_player_hack)
      $local:per_player_daily_scan(who);
    endif
    if (index >= lengthp)
      index = 1;
    else
      index = index + 1;
    endif
    num_processed = num_processed + 1;
    if (num_processed > lengthp)
      if (this.repeat_cycle)
        "If we've gotten everyone up to threshold, try measuring some later than that.";
        early = early + 24 * 60 * 60;
        tooidle = tooidle * 4;
        tooidletime = tooidletime - tooidle;
        num_repetitions = num_repetitions + 1;
        num_processed = 0;
        if (early > time())
          "Don't spin our wheels when we've measured everything!";
          keep_going = 0;
        endif
      else
        keep_going = 0;
      endif
    endif
    this.working = players[index];
  endwhile
  return {num_processed, num_repetitions};
endif
