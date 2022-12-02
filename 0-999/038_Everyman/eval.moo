#38:eval   this none this rxd

"eval(code)";
"Evaluate code with $no_one's permissions (so you won't damage anything).";
"If code does not begin with a semicolon, set this = caller (in the code to be evaluated) and return the value of the first `line' of code.  This means that subsequent lines will not be evaluated at all.";
"If code begins with a semicolon, set this = caller and let the code decide for itself when to return a value.  This is how to do multi-line evals.";
exp = args[1];
if (this:bad_eval(exp))
  return E_PERM;
endif
set_task_perms(this);
if (exp[1] != ";")
  return eval(tostr("this=", caller, "; return ", exp, ";"));
else
  return eval(tostr("this=", caller, ";", exp, ";"));
endif
