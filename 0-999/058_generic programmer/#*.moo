#58:#*   any any any rd

"Copied from Player Class hacked with eval that does substitutions and assorted stuff (#8855):# by Geust (#24442) Sun May  9 20:19:05 1993 PDT";
"#<string>[.<property>|.parent] [exit|player|inventory] [for <code>] returns information about the object (we'll call it <thing>) named by string.  String is matched in the current room unless one of exit|player|inventory is given.";
"If neither .<property>|.parent nor <code> is specified, just return <thing>.";
"If .<property> is named, return <thing>.<property>.  .parent returns parent(<thing>).";
"If <code> is given, it is evaluated, with the value returned by the first part being substituted for %# in <code>.";
"For example, the command";
"  #JoeFeedback.parent player for toint(%#)";
"will return 26026 (unless Joe has chparented since writing this).";
set_task_perms(player);
if (!(whatstr = verb[2..dot = min(index(verb + ".", "."), index(verb + ":", ":")) - 1]))
  player:notify("Usage:  #string [exit|player|inventory]");
  return;
elseif (!args)
  what = player:my_match_object(whatstr);
elseif (index("exits", args[1]) == 1)
  what = player.location:match_exit(whatstr);
elseif (index("inventory", args[1]) == 1)
  what = player:match(whatstr);
elseif (index("players", args[1]) == 1)
  what = $string_utils:match_player(whatstr);
  if ($command_utils:player_match_failed(what, whatstr))
    return;
  endif
else
  what = player:my_match_object(whatstr);
endif
if (!valid(what) && match(whatstr, "^[0-9]+$"))
  what = toobj(whatstr);
endif
if ($command_utils:object_match_failed(what, whatstr))
  return;
endif
while (index(verb, ".parent") == dot + 1)
  what = parent(what);
  dot = dot + 7;
endwhile
if (dot >= length(verb))
  val = what;
elseif ((value = $code_utils:eval_d(tostr("return ", what, verb[dot + 1..$], ";")))[1])
  val = value[2];
else
  player:notify_lines(value[2]);
  return;
endif
if (prepstr)
  program = strsub(iobjstr + ";", "%#", toliteral(val));
  end = 1;
  "while (\"A\" <= (l = argstr[end]) && l <= \"Z\")";
  while ("A" <= (l = program[end]) && l <= "Z")
    end = end + 1;
  endwhile
  if (program[1] == ";" || program[1..end - 1] in {"if", "for", "fork", "return", "while", "try"})
    program = $code_utils:substitute(program, this.eval_subs);
  else
    program = $code_utils:substitute("return " + program, this.eval_subs);
  endif
  if ((value = eval(program))[1])
    player:notify(this:eval_value_to_string(value[2]));
  else
    player:notify_lines(value[2]);
    nerrors = length(value[2]);
    player:notify(tostr(nerrors, " error", nerrors == 1 ? "." | "s."));
  endif
else
  player:notify(this:eval_value_to_string(val));
endif
