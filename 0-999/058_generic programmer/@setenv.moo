#58:@setenv   any any any rd

"Usage: @setenv <environment string>";
"Set your .eval_env property.";
set_task_perms(player);
if (!argstr)
  player:notify(tostr("Usage:  ", verb, " <environment string>"));
  return;
endif
player:notify(tostr("Current eval environment is: ", player.eval_env));
result = player:set_eval_env(argstr);
if (typeof(result) == ERR)
  player:notify(tostr(result));
  return;
endif
player:notify(tostr(".eval_env set to \"", player.eval_env, "\" (", player.eval_ticks, " ticks)."));
