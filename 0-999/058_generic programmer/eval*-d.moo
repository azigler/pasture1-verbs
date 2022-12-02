#58:eval*-d   any any any rd

"A MOO-code evaluator.  Type `;CODE' or `eval CODE'.";
"Calls player:eval_cmd_string to first transform CODE in any way appropriate (e.g., prefixing .eval_env) and then do the actual evaluation.  See documentation for this:eval_cmd_string";
"If you set your .eval_time property to 1, you find out how many ticks and seconds you used.";
"If eval-d is used, the evaluation is performed as if the debug flag were unset.";
if (player != this)
  player:tell("I don't understand that.");
  return;
elseif (!player.programmer)
  player:tell("You need to be a programmer to eval code.");
  return;
endif
set_task_perms(player);
it = ftime();
result = player:eval_cmd_string(argstr, verb != "eval-d");
ft = ftime();
dt = ft - it;
if (result[1])
  player:notify(this:eval_value_to_string(result[2]));
  if (player:prog_option("eval_time") && !`output_delimiters(player)[2] ! ANY')
    player:notify(tostr("[", result[3], " tick", result[3] != 1 ? "s" | "", " used this cycle, ", floatstr(dt, 2), " seconds elapsed.]"));
  endif
else
  player:notify_lines(result[2]);
  nerrors = length(result[2]);
  player:notify(tostr(nerrors, " error", nerrors == 1 ? "." | "s."));
endif
