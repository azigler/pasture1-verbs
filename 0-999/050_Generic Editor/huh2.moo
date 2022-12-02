#50:huh2   this none this rxd

"This catches subst and find commands that don't fit into the usual model, e.g., s/.../.../ without the space after the s, and find commands without the verb `find'.  Still behaves in annoying ways (e.g., loses if the search string contains multiple whitespace), but better than before.";
set_task_perms(caller_perms());
if ((c = callers()) && (c[1][1] != this || length(c) > 1))
  return pass(@args);
endif
verb = args[1];
v = 1;
vmax = min(length(verb), 5);
while (v <= vmax && verb[v] == "subst"[v])
  v = v + 1;
endwhile
argstr = $code_utils:argstr(verb, args[2]);
if (v > 1 && v <= length(verb) && ((vl = verb[v]) < "A" || vl > "Z"))
  argstr = verb[v..$] + (argstr && " ") + argstr;
  return this:subst();
elseif ("/" == verb[1])
  argstr = verb + (argstr && " ") + argstr;
  return this:find();
else
  pass(@args);
endif
