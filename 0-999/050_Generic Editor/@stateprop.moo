#50:@stateprop   any (for/about) this rd

if (!$perm_utils:controls(player, this))
  player:tell(E_PERM);
  return;
endif
if (i = index(dobjstr, "="))
  default = dobjstr[i + 1..$];
  prop = dobjstr[1..i - 1];
  if (argstr[1 + index(argstr, "=")] == "\"")
  elseif (default[1] == "#")
    default = toobj(default);
  elseif (index("0123456789", default[1]))
    default = toint(default);
  elseif (default == "{}")
    default = {};
  endif
else
  default = 0;
  prop = dobjstr;
endif
if (typeof(result = this:set_stateprops(prop, default)) == ERR)
  player:tell(result == E_RANGE ? tostr(".", prop, " needs to hold a list of the same length as .active (", length(this.active), ").") | (result != E_NACC ? result | prop + " is already a property on an ancestral editor."));
else
  player:tell("Property added.");
endif
