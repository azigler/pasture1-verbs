#68:add_name   this none this rxd

":add_name(name[,isextra]) adds name to the list of options recognized.";
"name must be a nonempty string and must not contain spaces, -, +, !, or =.";
"isextra true means that name isn't an actual option (recognized by :get) but merely a name that the option setting command should recognize to set a particular combination of options.  Actual options go in .names; others go in .extras";
{name, ?isextra = 0} = args;
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (!name || match(name, "[-!+= ]"))
  "...name is blank or contains a forbidden character";
  return E_INVARG;
elseif (name in this.names)
  "...name is already in option list";
  if (isextra)
    this.names = setremove(this.names, name);
    this.extras = setadd(this.extras, name);
    return 1;
  else
    return 0;
  endif
elseif (name in this.extras)
  if (isextra)
    return 0;
  else
    this.names = setadd(this.names, name);
    this.extras = setremove(this.extras, name);
    return 1;
  endif
else
  char = this._namelist[1];
  if (isextra)
    this.extras = setadd(this.extras, name);
  else
    this.names = setadd(this.names, name);
  endif
  if (!index(this._namelist, char + name + char))
    this._namelist = tostr(this._namelist, name, char);
  endif
  return 1;
endif
