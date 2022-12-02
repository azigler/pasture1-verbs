#50:here_huh   this none this rxd

"This catches subst and find commands that don't fit into the usual model, e.g., s/.../.../ without the space after the s, and find commands without the verb `find'.  Still behaves in annoying ways (e.g., loses if the search string contains multiple whitespace), but better than before.";
if (caller != this && caller_perms() != player)
  return E_PERM;
endif
{verb, args} = args;
v = 1;
vmax = min(length(verb), 5);
while (v <= vmax && verb[v] == "subst"[v])
  v = v + 1;
endwhile
argstr = $code_utils:argstr(verb, args);
if (v > 1 && (v <= length(verb) && ((vl = verb[v]) < "A" || vl > "Z")))
  argstr = verb[v..$] + (argstr && " ") + argstr;
  this:subst();
  return 1;
elseif ("/" == verb[1])
  argstr = verb + (argstr && " ") + argstr;
  this:find();
  return 1;
else
  return 0;
endif
