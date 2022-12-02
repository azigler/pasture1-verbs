#99:add_group   this none this rxd

":add_group (STR group)";
"Adds <group> to the groups and makes a property for it.";
if (!this:trusts(caller_perms()))
  return E_PERM;
elseif (!(args && args[1] && typeof(args[1]) == STR))
  return E_INVARG;
elseif (args[1] in this.groups)
  return 0;
else
  this.groups = setadd(this.groups, args[1]);
  arg1 = {this, "group_" + args[1], {}, {$code_utils:verb_perms(), "r"}};
  arg2 = {this, tostr("group_", args[1], "_regexp"), "", arg1[4]};
  if ($object_utils:has_callable_verb(#0, "add_property"))
    $add_property(@arg1);
    $add_property(@arg2);
  else
    add_property(@arg1);
    add_property(@arg2);
  endif
  $options["ansi"]:add_name(args[1]);
  return 1;
endif
