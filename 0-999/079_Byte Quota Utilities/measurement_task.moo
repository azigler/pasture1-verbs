#79:measurement_task   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  start_time = time();
  {num_processed, num_repetitions} = this:measurement_task_body(args[1]);
  players = players();
  lengthp = length(players);
  if (!num_repetitions && num_processed < lengthp / 2)
    "Add this in because we aren't getting people summarized like we should.  We're going to work for way longer now, cuz we're going to do a second pass, but we really need to get those summaries done.  Only do this if we hardly did any work.  Note the -1 here: measure all newly created objects as well.  More work, sigh.";
    extra_end = time() + 3600 * 3;
    for x in (players)
      if (is_player(x) && time() < extra_end)
        "Robustness as above, plus don't run all day.  My kingdom for a break statement";
        this:summarize_one_user(x, -1);
      endif
      $command_utils:suspend_if_needed(0);
    endfor
  endif
  $mail_agent:send_message(player, this.report_recipients, "quota-utils report", {tostr("About to measure objects of player ", this.working.name, " (", this.working, "), ", $string_utils:ordinal(this.working in players), " out of ", lengthp, ".  We processed ", num_processed + lengthp * num_repetitions, " players in this run in ", num_repetitions, " time", num_repetitions == 1 ? "" | "s", " through all players.  Total time spent:  ", $time_utils:dhms(time() - start_time), ".")});
endif
