#79:measurement_task_nofork   this none this rxd

"This is a one-shot run of the measurement task, as opposed to :measurement_task, which will fork once per day.";
if (!caller_perms().wizard)
  return E_PERM;
else
  {num_processed, num_repetitions} = this:measurement_task_body();
  $mail_agent:send_message(player, player, "quota-utils report", {"finished one shot run of measurement task: processed ", num_processed, " players in ", num_repetitions, " runs through all players."});
endif
