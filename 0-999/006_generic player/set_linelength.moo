#6:set_linelength   this none this rxd

"Set linelength.  Linelength must be an integer >= 10.";
"If wrap is currently off (i.e. linelength is less than 0), maintains sign.  That is, this function *takes* an absolute value, and coerces the sign to be appropriate.";
"If you want to override the dwimming of wrap, pass in a second argument.";
"returns E_PERM if not allowed, E_INVARG if linelength is too low, otherwise the linelength.";
if (caller != this && !$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (abs(len = args[1]) < 10)
  return E_INVARG;
elseif (length(args) > 1)
  this.linelen = len;
else
  "DWIM here.";
  this.linelen = this.linelen > 0 ? len | -len;
  return len;
endif
