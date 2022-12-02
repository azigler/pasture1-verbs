#56:read   this none this rxd

"$command_utils:read() -- read a line of input from the player and return it";
"Optional argument is a prompt portion to replace `a line of input' in the prompt.";
"";
"Returns E_PERM if the current task is not the most recent task spawned by a command from player.";
{?prompt = "a line of input"} = args;
c = callers();
p = c[$][5];
p:notify(tostr("[Type ", prompt, " or `@abort' to abort the command.]"));
try
  ans = read();
  if ($string_utils:trim(ans) == "@abort")
    p:notify(">> Command Aborted <<");
    kill_task(task_id());
  endif
  return ans;
except error (ANY)
  return error[1];
endtry
