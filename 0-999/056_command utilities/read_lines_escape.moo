#56:read_lines_escape   this none this rxd

"$command_utils:read_lines_escape(escapes[,help]) -- read zero or more lines of input";
"";
"Similar to :read_lines() except that help is available and one may specify other escape sequences to terminate the read.";
"  escapes should be either a string or list of strings; this specifies which inputs other from `.' or `@abort' should terminate the read (... don't use anything beginning with a `.').";
"  help should be a string or list of strings to be printed in response to the player typing `?'; the first line of the help text should be a general comment about what the input text should be used for.  Successive lines should describe the effects of the alternative escapes.";
"Returns {end,list-of-strings-input} where end is the particular line that terminated this input or 0 if input terminated normally with `.'.  Returns E_PERM if the current task is not a command task that has never called suspend().  ";
"@abort and lines beginning with `.' are treated exactly as with :read_lines()";
{escapes, ?help = "You are currently in a read loop."} = args;
c = callers();
p = c[$][5];
escapes = {".", "@abort", @typeof(escapes) == LIST ? escapes | {escapes}};
p:notify(tostr("[Type lines of input; `?' for help; end with `", $string_utils:english_list(escapes, "", "' or `", "', `", ""), "'.]"));
ans = {};
escapes[1..0] = {"?"};
"... set up the help text...";
if (typeof(help) != LIST)
  help = {help};
endif
help[2..1] = {"Type `.' on a line by itself to finish.", "Anything else with a leading period is entered with the period removed.", "Type `@abort' to abort the command completely."};
while (1)
  try
    line = read();
    if ((trimline = $string_utils:trimr(line)) in escapes)
      if (trimline == ".")
        return {0, ans};
      elseif (trimline == "@abort")
        p:notify(">> Command Aborted <<");
        kill_task(task_id());
      elseif (trimline == "?")
        p:notify_lines(help);
      else
        return {trimline, ans};
      endif
    else
      if (line && line[1] == ".")
        line[1..1] = "";
      endif
      ans = {@ans, line};
    endif
  except error (ANY)
    return error[1];
  endtry
endwhile
