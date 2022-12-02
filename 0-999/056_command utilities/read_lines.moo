#56:read_lines   this none this rxd

"$command_utils:read_lines([max]) -- read zero or more lines of input";
"";
"Returns a list of strings, the (up to MAX, if given) lines typed by the player.  Returns E_PERM if the current task is not a command task that has never called suspend().";
"In order that one may enter arbitrary lines, including \"@abort\" or \".\", if the first character in an input line is `.' and there is some nonwhitespace afterwords, the `.' is dropped and the rest of the line is taken verbatim, so that, e.g., \".@abort\" enters as \"@abort\" and \"..\" enters as \".\".";
"--- Inline editor ---";
return $edit_utils:editor();
"--- Inline editor ---";
"(Remove the above line if you wish for normal read_lines prompts.)";
{?max = 0} = args;
c = callers();
p = c[$][5];
p:notify(tostr("[Type", max ? tostr(" up to ", max) | "", " lines of input; use `.' to end or `@abort' to abort the command.]"));
ans = {};
while (1)
  try
    line = read();
    if (line[1..min(6, $)] == "@abort" && (tail = line[7..$]) == $string_utils:space(tail))
      p:notify(">> Command Aborted <<");
      kill_task(task_id());
    elseif (!line || line[1] != ".")
      ans = {@ans, line};
    elseif ((tail = line[2..$]) == $string_utils:space(tail))
      return ans;
    else
      ans = {@ans, tail};
    endif
    if (max && length(ans) >= max)
      return ans;
    endif
  except error (ANY)
    return error[1];
  endtry
endwhile
