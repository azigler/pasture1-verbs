#58:eval_cmd_string   this none this rxd

":eval_cmd_string(string[,debug])";
"Evaluates the string the way this player would normally expect to see it evaluated if it were typed on the command line.  debug (defaults to 1) indicates how the debug flag should be set during the evaluation.";
" => {@eval_result, ticks, seconds}";
"where eval_result is the result of the actual eval() call.";
"";
"For the case where string is an expression, we need to prefix `return ' and append `;' to string before passing it to eval().  However this is not appropriate for statements, where it is assumed an explicit return will be provided somewhere or that the return value is irrelevant.  The code below assumes that string is an expression unless it either begins with a semicolon `;' or one of the MOO language statement keywords.";
"Next, the substitutions described by this.eval_subs, which should be a list of pairs {string, sub}, are performed on string";
"Finally, this.eval_env is prefixed to the beginning while this.eval_ticks is subtracted from the eventual tick count.  This allows string to refer to predefined variables like `here' and `me'.";
set_task_perms(caller_perms());
{program, ?debug = 1} = args;
program = program + ";";
debug = debug ? 38 | 0;
if (!match(program, "^ *%(;%|%(if%|fork?%|return%|while%|try%)[^a-z0-9A-Z_]%)"))
  program = "return " + program;
endif
program = tostr(this.eval_env, ";", $code_utils:substitute(program, this.eval_subs));
ticks = ticks_left() - 53 - this.eval_ticks + debug;
seconds = seconds_left();
value = debug ? eval(program) | $code_utils:eval_d(program);
seconds = seconds - seconds_left();
ticks = ticks - ticks_left();
return {@value, ticks, seconds};
