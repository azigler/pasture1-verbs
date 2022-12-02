#59:show_verbdef   this none this rxd

set_task_perms(caller_perms());
{object, vname} = args;
if (!(hv = $object_utils:has_verb(object, vname)))
  player:notify("That object does not define that verb.");
  return;
elseif (hv[1] != object)
  player:notify(tostr("Object ", object, " does not define that verb, but its ancestor ", hv[1], " does."));
  object = hv[1];
endif
try
  {owner, perms, names} = verb_info(object, vname);
except error (ANY)
  player:notify(error[2]);
  return;
endtry
arg_specs = verb_args(object, vname);
player:notify(tostr(object, ":", names));
player:notify(tostr("Owner:            ", valid(owner) ? tostr(owner.name, " (", owner, ")") | "*** NONE ***"));
player:notify(tostr("Permissions:      ", perms));
player:notify(tostr("Direct Object:    ", arg_specs[1]));
player:notify(tostr("Preposition:      ", arg_specs[2]));
player:notify(tostr("Indirect Object:  ", arg_specs[3]));
