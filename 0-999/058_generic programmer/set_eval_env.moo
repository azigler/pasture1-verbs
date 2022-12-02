#58:set_eval_env   this none this rxd

"set_eval_env(string);";
"Run <string> through eval.  If it doesn't compile, return E_INVARG.  If it crashes, well, it crashes.  If it works okay, set .eval_env to it and set .eval_ticks to the amount of time it took.";
if (is_player(this) && $perm_utils:controls(caller_perms(), this))
  program = args[1];
  value = $no_one:eval_d(";ticks = ticks_left();" + program + ";return ticks - ticks_left() - 2;");
  if (!value[1])
    return E_INVARG;
  elseif (typeof(value[2]) == ERR)
    return value[2];
  endif
  try
    ok = this.eval_env = program;
    this.eval_ticks = value[2];
    return 1;
  except error (ANY)
    return error[1];
  endtry
endif
