#59:eval_d   any any any rx

":eval_d(code...) => {compiled?,result}";
"This works exactly like the builtin eval() except that the code is evaluated ";
"as if the d flag were unset.";
code = {"set_verb_code(this,\"eval_d_util\",{\"\\\"Do not remove this verb!  This is an auxiliary verb for :eval_d().\\\";\"});", "dobj=iobj=this=#-1;", "dobjstr=iobjstr=prepstr=argstr=verb=\"\";", tostr("caller=", caller, ";"), "set_task_perms(caller_perms());", @args};
if (!caller_perms().programmer)
  return E_PERM;
elseif (caller_perms() == $no_one && $no_one:bad_eval(tostr(@args)))
  return E_PERM;
elseif (svc = set_verb_code(this, "eval_d_util", code))
  lines = {};
  for line in (svc)
    if (index(line, "Line ") == 1 && (n = toint(line[6..(colon = index(line + ":", ":")) - 1])))
      lines = {@lines, tostr("Line ", n - 5, line[colon..$])};
    else
      lines = {@lines, line};
    endif
  endfor
  return {0, lines};
else
  set_task_perms(caller_perms());
  return {1, this:eval_d_util()};
endif
