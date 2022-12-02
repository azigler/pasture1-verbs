#68:remove_name   this none this rxd

":remove_name(name) removes name from the list of options recognized.";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (!((name = args[1]) in this.names || name in this.extras))
  "...hmm... already gone...";
  return 0;
else
  char = this._namelist[1];
  this._namelist = strsub(this._namelist, char + name + char, char);
  this.names = setremove(this.names, name);
  this.extras = setremove(this.extras, name);
  return 1;
endif
