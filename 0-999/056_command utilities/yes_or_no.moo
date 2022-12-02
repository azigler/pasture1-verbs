#56:yes_or_no   this none this rxd

":yes-or-no([prompt]) -- prompts the player for a yes or no answer and returns a true value iff the player enters a line of input that is some prefix of \"yes\"";
"";
"Returns E_NONE if the player enters a blank line, E_INVARG, if the player enters something that isn't a prefix of \"yes\" or \"no\", and E_PERM if the current task is not a command task that has never called suspend().";
c = callers();
p = c[$][5];
p:notify(tostr(args ? args[1] + " " | "", "[Enter `yes' or `no']"));
try
  ans = read(@caller == p || $perm_utils:controls(caller_perms(), p) ? {p} | {});
  if (ans = $string_utils:trim(ans))
    if (ans == "@abort")
      p:notify(">> Command Aborted <<");
      kill_task(task_id());
    endif
    return index("yes", ans) == 1 || (index("no", ans) != 1 && E_INVARG);
  else
    return E_NONE;
  endif
except error (ANY)
  return error[1];
endtry
