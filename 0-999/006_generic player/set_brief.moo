#6:set_brief   this none this rxd

"set_brief(value)";
"set_brief(value, anything)";
"If <anything> is given, add value to the current value; otherwise, just set the value.";
if (!($perm_utils:controls(caller_perms(), this) || this == caller))
  return E_PERM;
else
  if (length(args) == 1)
    this.brief = args[1];
  else
    this.brief = this.brief + args[1];
  endif
endif
